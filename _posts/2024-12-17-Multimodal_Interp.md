---
layout: post
title: A quick look into multimodal interpretability
thumbnail-img: "/assets/img/multimodal_thumbnail.png"
tags: [Projects]
author: Lawrence Feng
---

# A quick look into multimodal interpretability

_**this blog post is currently in progress**_

*The idea for this project was my own, but much of this work was done collaboratively for my Introduction to Machine Learning (10-701) final project.*

## Overview and Main Findings

In this work, we interpret the behavior of a multimodal *vision-language* model (VLM) using a sparse autoencoder (SAE) trained only on text inputs. That is, the SAE was trained for the purpose of interpreting features in the activation space of a *language* model, yet we found it accurately interpreted features in the activation space of a *vision-language* model.

Our multimodal model of choice is LLaVA (`Intel/llava-gemma-2b`).

We also intervene on the intermediate activations of LLaVA by using the interpretable features discovered by the SAE. We then comment on the behavior of the model after intervention.

## Introduction and Background

Most works in the field of mechanistic interpretability have so far focused on language models. However, most state of the art transformer models, such as GPT-4o and Claude-3.5, are multimodal. Given this trend, among other (philosophical) reasons, I would guess that any sort of artificial general intelligence (AGI) will be multimodal. Therefore, it would probably be useful to explore the interpretability of these multimodal models. Not only that, but peering into how these models can process language *and* images seems qualitatively different than peering into unimodal language models.

### A brief overview of LLaVA

The LLaVA architecture  consists of three main components: a vision encoder, a multimodal integration module, and a language model. In this project, we used Gemma because of the existing interpretability work done on it (e.g. GemmaScope).

Here's how LLaVA works. CLIP extracts image features, then a linear layer projects the image embeddings to match the input dimensionality of the language model.  Next, the embedded language instruction is concatenated with the projected image embedding. Finally, the output of the previous steps is processed by a fine-tuned google/gemma-2b model. The model was loaded using the Hugging Face Transformers library, then wrapped with a custom HookedTransformer from the transformer_lens library to facilitate access to intermediate activations.

## Feature Analysis

The left column of the table indicates the class of the image given to the VLM. The language prompt was "describe the image."

The right column of the table indicates the automatically interpreted neurons in the SAE that were activated the most by the prompt. These are the interpreted features from the language-only SAE. You can see that an image of pizza activations neuron 7310 in the SAE, which appears to a pizza neuron! 

| **CLASS**           | **Descriptions with Index**                                                                                  |
|---------------------|-------------------------------------------------------------------------------------------------------------|
| pizza               | 4270 details about food items and their ingredients                                                          |
|                     | 8266 food-related terms and descriptions, particularly those highlighting deliciousness and preparation methods|
|                     | 9573 culinary terms and ingredients related to meal preparation                                               |
|                     | 7310 references to **pizza**, including different types and descriptions                                      |
| golden retriever    | 4501 references to loyal companions, specifically dogs                                                       |
| lakeside            | 9864 features and attributes of lakes and bodies of water                                                     |
|                     | 3429 elements relating to picturesque scenery and backgrounds                                                 |
|                     | 4105 descriptions of beaches and coastal locations                                                           |
| coral reef          | 6878 terms related to oceanic fauna and their habitats                                                       |
| alps                | 8670 terms related to steep terrain and slopes                                                                |
|                     | 3429 elements relating to picturesque scenery and backgrounds                                               |
|                     | 6735 references to adventurous activities in specific scenic locations                                       |
| goldfish            | 8207: phrases related to the sale and care of animals                                                        |
|                     | 12287: references to animals and their interactions                                                          |
| rocking chair       | 9662 descriptions of physical spaces and furniture                                                           |
|                     | 15413 locations or arrangements of people and furniture                                                      |
|                     | 5670 elements related to outdoor dining experiences                                                          |

## Intervention example

Our interventions were not super systematic, but we did find some interesting results. 

Inspired by Golden Gate Claude, we looked into using the interpretable features found by the SAE to modify the behavior of LLaVA.
By writing a feature as a one-hot vector in the encoding space and multiplying it by the weight (but not the bias) of the decoder layer of the SAE, we get a vector in the embedding space of LLaVA that we can add or subtract to the activations in the interpreted layer of LLaVA.

One strong example of successfully influencing the model's output was from subtracting the feature *4501 references to loyal companions, specifically dogs* from the activations when running the model on the following photo.

<img src="/assets/img/dog.png" alt="dog from MNIST" width="400" class="center"/>

Original output:

> The image features a small black and white dog sitting in the dark, with its ears perked up. The dog is wearing a red collar, and it appears to be looking at the camera. The dog is positioned in the center of the scene, with its head tilted to the side. The background is dark, creating a dramatic and moody atmosphere.

Output after intervention:

> The image features a close-up of a person's hands holding a cell phone, with the focus on the hands and the surrounding area. The cell phone is in the middle of the hands, with the hands spread out to the sides. The image also includes a background that can be seen in the upper part of the cell phone, and the overall context suggests that the person is using the cell phone.

## Links

[Here is the code for this project](https://github.com/lawrencefeng17/llava-interpret.git)


