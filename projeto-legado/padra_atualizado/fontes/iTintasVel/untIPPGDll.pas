unit untIPPGDll;

interface

type
  IPPGDll = interface
    ['{48B82585-08E3-4E21-A9DD-E59E16A48CAB}']
    function GetDLLVersion(): string;

    function GetFormula(const pszPMRoot: string; var pszSearchResultsBuffer: string; const pszFormulaId: string;
      const iGetDilution: Integer; var iGotDilution: Integer): Integer; stdcall;

    function GetColors(const pszPMRoot: string; var pszSearchResultsBuffer: string; const iBrandId, iMixingSchemeId,
      iPaintSystemId: Integer; const pszOEMCode: string; const iSourceTypeId: Integer; const pszManufacturer, pszColorDescription: string;
      const iUsageId, iColorFamilyId, iModelYear: Integer; var pszPanel: string): Integer; stdcall;

    function SetDebug(flag: Integer): Integer; stdcall;
  end;

implementation

end.
