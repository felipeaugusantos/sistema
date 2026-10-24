unit untTEmpresa;

interface

uses Uni,
     untTCidade;

type
  TEmpresa = class(TObject)
    private
      FCodigo: string;
      FRazaoSocial: string;
      FNomeFantasia: string;
      FEndereco: string;
      FCNPJ: string;
      FCEP: string;
      FNumero: string;
      FBairro: string;
      FFone01: string;
      FFax: string;
      FEmail: string;
      FComplementoEndereco: string;
      FInscricaoEstadual: string;
      FInscricaoMunicipal: string;
      FCNAE: string;
      FCidade: TCidade;
      FNomeContabilista: string;
      FCpfContabilista: string;
      FCrcContabilista: string;
      FCNPJEscritorioContabilidade: string;
      FCepContabilista: string;
      FEnderecoContabilista: string;
      FNumeroContabilista: string; // Numero do endereço do contabilista
      FComplementoEnderecoContabilista: string;
      FBairroContabilista: string;
      FFoneContabilista: string;
      FFaxContabilista: string;
      FEmailContabilista: string;
      FIbgeContabilista: string;
      FUfContabilista: string;

      procedure pCarregaQryDados(qryAux: TUniQuery);
    public
      procedure pCarregaEmpresa;

      property strCodigo: string read FCodigo write FCodigo;
      property strRazaoSocial: string read FRazaoSocial;
      property strNomeFantasia: string read FNomeFantasia;
      property strEndereco: string read FEndereco;
      property strCNPJ: string read FCNPJ;
      property strCEP: string read FCEP;
      property strNumero: string read FNumero;
      property strBairro: string read FBairro;
      property strFone01: string read FFone01;
      property strFax: string read FFax;
      property strEmail: string read FEmail;
      property strComplementoEndereco: string read FComplementoEndereco;
      property strInscricaoEstadual: string read FInscricaoEstadual;
      property strInscricaoMunicipal: string read FInscricaoMunicipal;
      property strCNAE: string read FCNAE;
      property cidade: TCidade read FCidade;
      property strNomeContabilista: string read FNomeContabilista;
      property strCpfContabilista: string read FCpfContabilista;
      property strCrcContabilista: string read FCrcContabilista;
      property strCNPJEscritorioContabilidade: string read FCNPJEscritorioContabilidade;
      property strCepContabilista: string read FCepContabilista;
      property strEnderecoContabilista: string read FEnderecoContabilista;
      property strNumeroContabilista: string read FNumeroContabilista;
      property strComplementoEnderecoContabilista: string read FComplementoEnderecoContabilista;
      property strBairroContabilista: string read FBairroContabilista;
      property strFoneContabilista: string read FFoneContabilista;
      property strFaxContabilista: string read FFaxContabilista;
      property strEmailContabilista: string read FEmailContabilista;
      property strIbgeContabilista: string read FIbgeContabilista;
      property strUfContabilista: string read FUfContabilista;

      constructor create(strCodEmp: string);
      destructor Destroy; override;
  end;

implementation

uses untFuncoes;

{ TEmpresa }

constructor TEmpresa.create(strCodEmp: string);
begin
  FCodigo := strCodEmp;
  FCidade := TCidade.Create;

  if not fEmptyStr(strCodEmp) then
    pCarregaEmpresa;
end;

destructor TEmpresa.Destroy;
begin
  FCidade.Free;

  inherited;
end;

procedure TEmpresa.pCarregaEmpresa;
  Var
    qryAux: TUniquery;
begin
  qryAux := fCriaQuery();

  try
    pCarregaQryDados(qryAux);

    FRazaoSocial := qryAux.FieldByName('EMP_NOMEMP').AsString;
    FNomeFantasia := qryAux.FieldByName('EMP_NOMFAN').AsString;
    FEndereco := qryAux.FieldByName('EMP_ENDERE').AsString;
    FCNPJ := qryAux.FieldByName('EMP_C_G_C_').AsString;
    FInscricaoEstadual := fTiraCaracEspeciais(qryAux.FieldByName('EMP_I_E_S_').AsString, True, True);
    FInscricaoMunicipal := qryAux.FieldByName('EMP_INSMUN').AsString;
    FCEP := fTiraCaracEspeciais(qryAux.FieldByName('EMP_C_E_P_').AsString, True, True);
    FNumero := qryAux.FieldByName('EMP_ENDNUM').AsString;
    FBairro := qryAux.FieldByName('EMP_BAIRRO').AsString;
    FFone01 := qryAux.FieldByName('EMP_FONE01').AsString;
    FComplementoEndereco := qryAux.FieldByName('EMP_ENDCMP').AsString;
    FFax := qryAux.FieldByName('EMP_F_A_X_').AsString;
    FEmail := qryAux.FieldByName('EMP_EMAIL_').AsString;
    FCNAE := qryAux.FieldByName('EMP_CNAEFI').AsString;
    FCidade.strNome := qryAux.FieldByName('CID_NOMCID').AsString;
    FCidade.strEstado := qryAux.FieldByName('CID_ESTADO').AsString;
    FCidade.strCodigoIbge := qryAux.FieldByName('IBGE').AsString;
    FNomeContabilista := qryAux.FieldByName('EMP_NOMCTB').AsString;
    FCpfContabilista := qryAux.FieldByName('EMP_CPFCTB').AsString;
    FCrcContabilista := qryAux.FieldByName('EMP_CRCCTB').AsString;
    FCNPJEscritorioContabilidade := qryAux.FieldByName('EMP_CGCCTB').AsString;
    FCepContabilista := qryAux.FieldByName('EMP_CEPCTB').AsString;
    FEnderecoContabilista := qryAux.FieldByName('EMP_ENDCTB').AsString;
    FNumeroContabilista := qryAux.FieldByName('EMP_NUMCTB').AsString;
    FComplementoEnderecoContabilista := qryAux.FieldByName('EMP_COMCTB').AsString;
    FBairroContabilista := qryAux.FieldByName('EMP_BAICTB').AsString;
    FFoneContabilista := qryAux.FieldByName('EMP_FONCTB').AsString;
    FFaxContabilista := qryAux.FieldByName('EMP_FAXCTB').AsString;
    FEmailContabilista := qryAux.FieldByName('EMP_EMACTB').AsString;
    FIbgeContabilista := qryAux.FieldByName('EMP_IBGCTB').AsString;
    FUfContabilista := qryAux.FieldByName('ESTADO_CTB').AsString;
  finally
    qryAux.Free;
  end;
end;

procedure TEmpresa.pCarregaQryDados(qryAux: TUniQuery);
begin
  qryAux.Close;
  qryAux.SQL.Clear;

  qryAux.SQL.Add('SELECT');
  //Dados da empresa
  qryAux.SQL.Add('  EMP_NOMEMP,');
  qryAux.SQL.Add('  EMP_NOMFAN,');
  qryAux.SQL.Add('  EMP_ENDERE,');
  qryAux.SQL.Add('  EMP_C_G_C_,');
  qryAux.SQL.Add('  EMP_C_E_P_,');
  qryAux.SQL.Add('  EMP_I_E_S_,');
  qryAux.SQL.Add('  EMP_CNAEFI,');
  qryAux.SQL.Add('  EMP_INSMUN,');
  qryAux.SQL.Add('  EMP_ENDNUM,');
  qryAux.SQL.Add('  EMP_ENDCMP,');
  qryAux.SQL.Add('  EMP_BAIRRO,');
  qryAux.SQL.Add('  EMP_FONE01,');
  qryAux.SQL.Add('  EMP_F_A_X_,');
  qryAux.SQL.Add('  EMP_EMAIL_,');

  //Daqui para baixo são dados do contabilista onde começar com "EMP_"
  qryAux.SQL.Add('  EMP_NOMCTB,');
  qryAux.SQL.Add('  EMP_CPFCTB,');
  qryAux.SQL.Add('  EMP_CRCCTB,');
  qryAux.SQL.Add('  EMP_CGCCTB,');
  qryAux.SQL.Add('  EMP_CEPCTB,');
  qryAux.SQL.Add('  EMP_ENDCTB,');
  qryAux.SQL.Add('  EMP_NUMCTB,');
  qryAux.SQL.Add('  EMP_COMCTB,');
  qryAux.SQL.Add('  EMP_BAICTB,');
  qryAux.SQL.Add('  EMP_FONCTB,');
  qryAux.SQL.Add('  EMP_FAXCTB,');
  qryAux.SQL.Add('  EMP_EMACTB,');
  qryAux.SQL.Add('  EMP_IBGCTB,');
  qryAux.SQL.Add('  CC.CID_ESTADO AS ESTADO_CTB,');
  qryAux.SQL.Add('  CE.CID_NOMCID,');
  qryAux.SQL.Add('  CE.CID_ESTADO,');
  qryAux.SQL.Add('  CE.CID_COIBGE AS IBGE');
  qryAux.SQL.Add('FROM');
  qryAux.SQL.Add('  CADEMP');
  qryAux.SQL.Add('  LEFT JOIN CADCID CE');
  qryAux.SQL.Add('   ON CE.CID_CODCID = EMP_CODCID');
  qryAux.SQL.Add('  LEFT JOIN CADCID CC');
  qryAux.SQL.Add('   ON CC.CID_COIBGE = EMP_IBGCTB');
  qryAux.SQL.Add('WHERE EMP_CODEMP = :CODEMP');
  qryAux.ParamByName('CODEMP').AsString := FCodigo;
  qryAux.Open;
end;


end.
