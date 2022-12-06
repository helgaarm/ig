Alias: $no-basis-shortnotice = http://hl7.no/fhir/structuredefinition/no-basis-appointmentresponse/no-basis-shortnotice
Alias: no-kodeverk-8268 = https://volven.no/produkt.asp?id=489319&catID=3&subID=8


Profile: HnCiticenPortalAppointmentResponse
Parent: NoBasisAppointmentResponse
Id: hn-CiticenPortal-AppointmentResponse
Title: "hn-CiticenPortal-AppointmentResponse"
Description: "Med AppointmentResponse for innbygger mulighet til å bekrefte og si i fra på Helsenorge hvis timeavtale ikke passer. For fremtidig bruk vil også være mulig for innbygger å tentativt bekrefte time, men samtidig foreslå nytt tidspunkt eller melde i fra om time ikke passer men samtidig foreslå ett nytt tidspunkt. Tabellen under viser hvilken informasjon som skal overføres til avsendende system via REST.  Ressursen er AppointmentResponse, med en egen profil som bygger på nasjonal profil for AppointmentResponse (NoBasisAppointmentResponse)"
* ^status = #draft
* identifier 2..*
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier contains
    no-citizenportal-sourcesystem 1..1 and
    no-citizenportal-client 1..1 
* identifier[no-citizenportal-sourcesystem].system = "http://ehelse.no/fhir/CodeSystem/no-citizenportal-sourceystem"
* identifier[no-citizenportal-client].system = "http://ehelse.no/fhir/CodeSystem/no-citizenportal-client"
* appointment.reference 0..0
* appointment.identifier 1..1
* appointment.identifier obeys system-required
* appointment.identifier.system ^short = "System should point to the source system where the appointment resides"
* appointment.identifier.system 1..1
* appointment.identifier.value ^short = "The value of the identifier is the instance identifier for the appointment in sending source systeme"
* appointment.identifier.value 1..1
* actor only Reference(Patient)
* actor.reference 0..0
* actor.reference ^short = "Profile uses only logical reference to reference actor and actor can only be a patient"
* actor.identifier 1..1
* actor.type = "Patient"
* actor.identifier obeys system-required
* actor.identifier obeys system-decided-by-type
* actor.identifier.system 1..1
* actor.identifier.value 1..1
* actor.identifier.type.coding.code from hn-CiticenPortal-ActorIdentiferType-VS
* actor.identifier.type.coding.code ^short = "Subset from Volven 8268"
* actor.identifier.type.coding.code ^definition = "Subset from Volven 8268 that only supports FNR and DNR"
* actor.identifier.type.coding.code ^mustSupport = true
* actor.identifier.type.coding.code ^binding.description = "HnCiticenPortalActorIdentifierTypeVS"



//invariant when value is set then there must be a system 
Invariant:  system-required
Description: "There should always be both system and value for an appointment"
Expression: "value.exists() implies system.exists()"
Severity:   #error


Invariant:  system-decided-by-type
Description: "If type 'FNR' then system points to urn:oid:2.16.578.1.12.4.1.4.1 else if type 'DNR' the system is urn:oid:2.16.578.1.12.4.1.4.2"
Expression: "(type.coding.code = 'FNR' implies system = 'urn:oid:2.16.578.1.12.4.1.4.1') and (type.coding.code = 'DNR' implies system = 'urn:oid:2.16.578.1.12.4.1.4.2')"
Severity:   #error


ValueSet: HnCiticenPortalActorIdentifierTypeVS
Id: hn-CiticenPortal-ActorIdentiferType-VS
Title: "Subset of codes from Volven 8268 Type identifikator"
Description: "The subset includes only fødselsnummer (FNR) and d-nummer (DNR)"
* no-kodeverk-8268#DNR
* no-kodeverk-8268#FNR


Instance: AppointmentResponseExample
InstanceOf: hn-CiticenPortal-AppointmentResponse
Description: "Example of AppointmentResponse"
* identifier[no-citizenportal-sourcesystem].value = "15-3fb9c0f4-1d9b-44b6-8d64-d36820115274"
* identifier[no-citizenportal-client].value = "Opus"
* appointment.identifier.system = "http://ehelse.no/fhir/CodeSystem/no-citizenportal-sourcesystem"
* appointment.identifier.value = "3546c8f7-3cd3-4693-929e-66501642504c"
* actor.identifier.system = "urn:oid:2.16.578.1.12.4.1.4.1"
* actor.identifier.value = "13116900216"
* participantStatus = #accepted




// No-Basis-ApointmentResponse
Profile: NoBasisAppointmentResponse
Parent: AppointmentResponse
Id: no-basis-AppointmentResponse
Title: "no-basis-AppointmentResponse"
Description: "Basisprofil for Norwegian AppointmentResponse information. Defined by HL7 Norway. Should be used as a basis for further profiling in use-cases where specific appointment respons information is needed. The basis profile is open, but derived profiles should close down the information elements according to specification relevant to the use-case."
* ^status = #draft
* extension ^slicing.discriminator.type = #value
* extension ^slicing.discriminator.path = "url"
* extension ^slicing.rules = #open
* extension ^min = 0
* extension contains $no-basis-shortnotice named shortNotice 0..*
* extension[shortNotice] ^definition = "Pasient can come on short notice."
* extension[shortNotice] ^min = 0
* extension[shortNotice].value[x] ^definition = "Pasient can come on short notice."



Extension: NoBasisShortNotice
Id: no-basis-shortnotice
Title: "no-basis-shortnotice"
Description: "The basis extension defines a boolean concept that expresses the possibility to meet on short notice if the there are available appointment slots."
* ^url = "http://hl7.no/fhir/structuredefinition/no-basis-appointmentresponse/no-basis-shortnotice"
* ^status = #draft
* ^context.type = #element
* ^context.expression = "AppointmentResponse"
* . ..1
* url = "http://hl7.no/fhir/structuredefinition/no-basis-appointmentresponse/no-basis-shortnotice" (exactly)
* value[x] only boolean
* value[x] ^short = "Pasient can come on short notice."