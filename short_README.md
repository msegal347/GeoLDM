# Sample generation with GeoLDM

This README provides instructions on how to pull the necessary Docker image, install required packages, download model weights, and run a deep learning model test in PyTorch.

## Environment SetupI
I use the official PyTorch Docker image, which can be pulled using the following command:

```
docker pull pytorch/pytorch:2.0.0-cuda11.7-cudnn8-runtime
```

While version `2.0.0` is used here, `2.0.1` or older version should work fine too.

## Package Requirements

The following packages are required to run the model test:

```
scipy
numpy
pytorch
rdkit        # Note: Installation via conda can be slow, consider using mamba instead
imageio
msgpack-python
```

## Download Model Weights

Model weights can be downloaded from the following [link](https://drive.google.com/drive/folders/1EQ9koVx-GA98kaKBS8MZ_jJ8g4YhdKsL?usp=sharing).

## Running the Model
### QM-9 dataset
To generate samples from the model, use the following command:

```python
python eval_analyze.py --model_path model_weights/qm9_latent2\
 --gpu_id 1 --n_samples 128 --batch_size_gen 64 --save_to_xyz True --use_rdkit False
```
### DRUGS dataset
For generating samples from the DRUGS dataset, first prepare the dataset by following the instructions [here](https://github.com/empyriumz/GeoLDM/tree/main/data/geom):



### Key command options:

- `--model_path`: This should be the path to your local model. I have tested with `qm9_latent2` (up to 29 atoms)and `drugs_latent2` (up to 181 atoms, much slower).
- `--save_to_xyz`: If set to True, this will save the generated molecules to xyz files. Each run will create a new subfolder inside the directory where you have stored the model weight.
- `--use_rdkit`: When set to True, this will use RDKit to analyze the quality of generated molecules. If set to False, it will return a simpler `stability_dict` with `"mol_stable"` and `"atm_stable"` percentages. 
  - Note: Running RDKit analysis can take a significant amount of time.
  - When using `drugs_latent2`, the resulting `"mol_stable"` will be close to 0. This is because the generated molecules are much larger. The ground truth dataset used for training also has nearly 0% stable molecules according to the paper.

- In terms of speed (single V100 GPU with a batch size of `64`):
  - about 1 second per sample on a for `QM9`
  - about 16 seconds per sample for `DRUGS` 