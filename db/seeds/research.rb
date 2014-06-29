puts 'seeding research projects...'

projects = [{
              name: "CRAV: Consulta Real em Ambiente Virtual",
              description: "The CRAV project is being developed jointly by the OPorto Archive and the University of Minho and aims at building a technological infrastructure for delivering online services to the archive's customers.",
              b_date: Time.parse("1-1-2006"),
              e_date: Time.parse("1-1-2007"),
              teacher_id: 1
            },
            {
              name: "RODA: Repositório de Objectos Digitais Autênticos",
              description: "The RODA project is being developed by the National Archives Directory Board (Direcção Geral de Arquivos Nacionais/Torre do Tombo) and the University of Minho and aims at raising awareness within public administration institutions on the issues of digital preservation and implementing an environment to ensure that. From this project will result a digital repository system capable of preseverving authentic digital objects. After its conclusion the National Archives will be able to ingest digital objects (e.g. still images, relational databases, text documents) produced by associated public institutions.",
              b_date: Time.parse("1-1-2006"),
              e_date: Time.parse("1-1-2007"),
              teacher_id: 1,
              url: "http://roda.iantt.pt"
            },
            {
              name: "DigitArq",
              description: "Over time, novel and richer finding aids are adopted by Archives, while at the same time, indexes, lists, inventories, catalogues and transference guides are produced to better serve the needs of its customers. Although these finding aids help users and archivists attain the artefacts they seek, they comprise an heterogeneous universe extremely hard to manage. The lack of coherence between most finding aids makes updating information a nightmare. To put an end to this scenario, it was carried out at the Arquivo Distrital do Porto (ADP) a project called DigitArq whose major goal was to homogenise the entire collection of finding aids and serve as a first attempt at the edification of a Digital Archive. This project comprised several stages. The first one consisted in the conversion of a series of paper-based documents and digital databases containing different types of finding aids to a single digital format based on an international standard - the General International Standard Archival Description - Digitalisation and Migration. The second stage of the project aimed at constructing a centralised database to store all the collected finding aids and developing special purpose software to manage all that information - Archival Management Software. A third stage consisted in the development of a search engine that allowed Internet users to find and browse the collections - Search Engine. Preservation is another great responsibility of an Archive. Different techniques can be used to address this issue such as microfilming and digitalisation. The ADP already provided a digitalisation service to their customers, which allowed them to buy digital copies of books and documents. This service was provided in an ad-hoc basis without a well-defined plan or workflow. Document images were kept on CD-ROMs, which where difficult to maintain and preserve. This setting was becoming unbearable given that a lot of images where not saved for future use due to the inherent difficulties in their retrieval. Since finding aids were now going to be published online it made sense to develop software to allow archivists to publish document images as well. This software should be able to simplify the digitalisation process (using digitalisation profiles) and guarantee the long-term preservation of the digital objects and the media involved. Such a system opens new opportunities for business, as images can be sold online to customers all over the world - Digital Objects Management Software.",
              b_date: Time.parse("1-1-2003"),
              e_date: Time.parse("1-1-2003"),
              teacher_id: 1,
              url: "http://roda.iantt.pt"
            }
            ]

projects.each do |project|
  ResearchProject.where(project).first_or_create!
end
