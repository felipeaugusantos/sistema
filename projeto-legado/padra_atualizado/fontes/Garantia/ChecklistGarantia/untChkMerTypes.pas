unit untChkMerTypes;

interface
 uses
  VCL.Forms;

 const
  VB_LOG_SIM: String = '1';
  VB_LOG_NAO: String = '0';

  SITUACAO_ITEM_NAO_ASSOSCIADO: String = '0';
  SITUACAO_ITEM_ASSOCIADO: String = '1';
  SITUACAO_ITEM_EXCLUIR: String = '2';

type
  TFrameClass = TFrame;

type

  TModoFrameCheckList = (Leitura, ExtrairJson);
  TSetModoFrameCheckList = set of TModoFrameCheckList;

  {$SCOPEDENUMS ON}
  TTipoCheckList = (Garantia, Troca);
  {$SCOPEDENUMS OFF}

  {$SCOPEDENUMS ON}
  TTipoResultado = (LinhaUnica, MultiplasLinhas, NA);
  {$SCOPEDENUMS OFF}

  TItemCheckListGarantiaRecord = Record
    intId: Integer;

    strCodEmp: String;                         //EMPRESA LOGADA

    strCodIte: String;                         //ITEGER.ITE_CODITE - código do item
    strIteAutInc: String;                      //ITECVG.AUTOINCREM - autoincrem item
    strConteudo: String;                       //ITECVG.ITE_CONTEU - CONTEÚDO

    strCodigo: String;                         //CADCVG.CVG_CODIGO  - código item checklist
    strDescricao: String;                      //CADCVG.CVG_DESCRI - DESCRICAO
    enuChkList: TTipoCheckList;                //CADCVG.CVG_TIPOVG - GRUPO DE CHECKLIST
    enuResultado: TTipoResultado;              //CADCVG.CVG_TIPORE
    strAutoincrem: String;                     //CADCVG.Autoincrem do checklist


    blnAssociado: Boolean;                     //ASSOCIADO - checklist associado ao item
    strSituacao: String;                       //SITUACAO -situação (inclusão/exclusao)
  public
    procedure pLimpar;
    function fTamanhoConteudo: Integer;
    function fTemConteudo: Boolean;
    function fGetConteudo: String;
    function fDefinirSituacao: String;
    class operator Equal(ValueA, ValueB: TItemCheckListGarantiaRecord): Boolean;
  end;

  TRecItemCheckListGarantia = TItemCheckListGarantiaRecord;


  TItemCklImportJson = Record
    strCodigo: String;
    strConteudo: String;
  end;
  TrecItemCklImportJson = TItemCklImportJson;

  TChekListImportJson = class
  public
    arrItensCkl: Array of TrecItemCklImportJson;
    strCodIte: String;
    strCodEmp: String;
    strGrupo: String;
    constructor Create;
    Destructor Destroy;override;
    procedure pAdicionarItem(recItemCklImportJson: TrecItemCklImportJson);
    function fTemItem: Boolean;
  end;

  TEnviarItemChecklistMercadoria = procedure(recItemCklMer: TRecItemCheckListGarantia) of Object;
  TProcEnviarItemChecklistMercadoria = reference to procedure(recItemCklMer: TRecItemCheckListGarantia);

  Type
  IFrameCheckList = Interface
  ['{D2910D98-D0F1-4338-B569-7B9060727725}']
    procedure pInserirItem(recItem: TRecItemCheckListGarantia);
  end;

  Type
  IFrameEditarChkMercadoriasView = Interface
  ['{DB2C1A9D-C454-4C26-9FEA-6399AAB70F69}']
    procedure pEditarCheckList(precItemCklMer: TRecItemCheckListGarantia;
      pRetornarItemChecklistMercadoria: TEnviarItemChecklistMercadoria; blnPermitirEdicao: Boolean);
    procedure pSetFrameCheckList(pTipoCheckList: TTipoCheckList; pFrame: IFrameCheckList);
  end;

type
  TTipoCheckListHelper = record helper for TTipoCheckList
    CONST
      STR_GARANTIA: String = 'G';
      STR_TROCA: String = 'T';
    procedure pSetAsString(const strValue: String);
    function fAsString: String;
  end;

type
  TTipoResultadoHelper = Record Helper for TTipoResultado
    CONST
      STR_LINHA_UNICA: String = 'L';
      STR_MULTIPLAS_LINHAS: String = 'M';
      STR_NA: String = 'N';

    procedure pSetAsString(const strValue: String);
    function fAsString: String;
  end;



implementation
uses
  untFuncoesSimples, System.SysUtils, System.StrUtils;

{ TItemCheckList }

class operator TItemCheckListGarantiaRecord.Equal(ValueA,
  ValueB: TItemCheckListGarantiaRecord): Boolean;
begin
  Result := (ValueA.strCodigo = ValueB.strCodigo);
  Result := Result and (ValueA.strDescricao = ValueB.strDescricao);
  Result := Result and (ValueA.strConteudo = ValueB.strConteudo);
  Result := Result and (ValueA.enuChkList = ValueB.enuChkList);
  Result := Result And (ValueA.enuResultado = ValueB.enuResultado);
  Result := Result And (ValueA.blnAssociado = ValueB.blnAssociado);
  Result := Result And (ValueA.strIteAutInc = ValueB.strIteAutInc);
  Result := Result and (ValueA.strCodIte = ValueB.strCodIte);
  Result := Result and (ValueA.strCodEmp = ValueB.strCodEmp);
  Result := Result And (ValueA.strSituacao = ValueB.strSituacao);
end;

function TItemCheckListGarantiaRecord.fDefinirSituacao: String;
begin
  if fEmptyStr(Self.strIteAutInc) then
  begin
    if Self.blnAssociado then
      Self.strSituacao := SITUACAO_ITEM_ASSOCIADO
    else
      Self.strSituacao := SITUACAO_ITEM_NAO_ASSOSCIADO;
  end
  else begin
    if Self.blnAssociado then
      Self.strSituacao := SITUACAO_ITEM_ASSOCIADO
    else
      Self.strSituacao := SITUACAO_ITEM_EXCLUIR;
  end;
  Result := Self.strSituacao;
end;

function TItemCheckListGarantiaRecord.fGetConteudo: String;
begin
  if Self.enuResultado =  TTipoResultado.NA then
    Result := 'N/A'
  else
  begin
    Result := Trim(Self.strConteudo);
    if Length(Result) > Self.fTamanhoConteudo then
      Result := Copy(Result, 1, Self.fTamanhoConteudo);
  end;
end;

function TItemCheckListGarantiaRecord.fTamanhoConteudo: Integer;
begin
  Case Self.enuResultado of
    TTipoResultado.LinhaUnica: Result := 40;
    TTipoResultado.MultiplasLinhas: Result := 240;
  else
    Result := 0;
  end;
end;

function TItemCheckListGarantiaRecord.fTemConteudo: Boolean;
begin
  Result := Not fEmptyStr(Self.strConteudo);
end;

procedure TItemCheckListGarantiaRecord.pLimpar;
begin
  Self.strAutoincrem := EmptyStr;
  Self.blnAssociado := False;
  Self.strCodigo := EmptyStr;
  Self.strDescricao := EmptyStr;
  self.strConteudo := EmptyStr;
  Self.enuChkList.pSetAsString(EmptyStr);
  Self.enuResultado.pSetAsString(EmptyStr);
  Self.strCodIte := EmptyStr;
  Self.strCodEmp := EmptyStr;
  Self.strIteAutInc := EmptyStr;
  Self.strSituacao := EmptyStr;
end;

{ TTipoCheckListHelper }

function TTipoCheckListHelper.fAsString: String;
begin
  Case Self of
    TTipoCheckList.Garantia: Result := Self.STR_GARANTIA;
    TTipoCheckList.Troca : Result := Self.STR_TROCA;
    else
      Result := EmptyStr;
  end;
end;

procedure TTipoCheckListHelper.pSetAsString(const strValue: String);
begin
  if strValue = Self.STR_TROCA Then
    Self := TTipoCheckList.Troca
  else if strValue = self.STR_GARANTIA then
    Self := TTipoCheckList.Garantia
  else
    Self := TTipoCheckList(Ord(-1));
end;

{ TTipoResultadoHelper }

function TTipoResultadoHelper.fAsString: String;
begin
  Case self of
    TTipoResultado.LinhaUnica: Result := Self.STR_LINHA_UNICA;
    TTipoResultado.MultiplasLinhas: Result := Self.STR_MULTIPLAS_LINHAS;
    TTipoResultado.NA: Result := self.STR_NA;
    Else
      Result := EmptyStr;
  end;
end;

procedure TTipoResultadoHelper.pSetAsString(const strValue: String);
  Var
    intValue: Integer;
begin
  intValue := IndexStr(strValue, [Self.STR_LINHA_UNICA, self.STR_MULTIPLAS_LINHAS, self.STR_NA]);
  Self := TTipoResultado(Ord(intValue));
end;

{ TChekListImportJson }

constructor TChekListImportJson.Create;
begin
  SetLength(Self.arrItensCkl, 0);
  Self.strCodIte := EmptyStr;
  Self.strCodEmp := EmptyStr;
  Self.strGrupo := EmptyStr;
end;

destructor TChekListImportJson.Destroy;
begin
  Finalize(Self.arrItensCkl);
  inherited;
end;

function TChekListImportJson.fTemItem: Boolean;
begin
  Result := Length(Self.arrItensCkl) > 0;
end;

procedure TChekListImportJson.pAdicionarItem(recItemCklImportJson: TrecItemCklImportJson);
begin
  SetLength(arrItensCkl, length(arrItensCkl)+1);
  Self.arrItensCkl[High(arrItensCkl)].strCodigo      := recItemCklImportJson.strCodigo;
  Self.arrItensCkl[High(arrItensCkl)].strConteudo      := recItemCklImportJson.strConteudo;
end;

end.
