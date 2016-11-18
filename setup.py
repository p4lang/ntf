from setuptools import setup

with open('README.md') as readme_file:
    readme = readme_file.read()

setup(
    name='ntf',
    version='0.1',
    description='NTF is a Python based network test framework.',
    long_description=readme,
    author='Shridevi Gurram',
    author_email='shridevi.gurram@barefootnetworks.com',
    url='https://github.com/barefootnetworks/ntf',
    packages=[
        'ntf', 'ntf.docker',
    ],
    package_dir={'': 'src'},
    scripts=['ntf'],
    zip_safe=False,
    license='Apache License',
    keywords='ntf',
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: Apache License',
        'Natural Language :: English',
        "Programming Language :: Python :: 2",
        'Programming Language :: Python :: 2.7',
    ]
)
