unit untImportacaoMetas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxProgressBar,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxTextEdit, cxMaskEdit,
  cxButtonEdit, FilenameEditFocus, Vcl.Menus, cxButtons, untPai, untTValidaExcel,
  Math, Types, Data.DB, Datasnap.DBClient, UniClientDataSet, frxClass;

type
  TfrmImportacaoMetas = class(TForm)
    plnFundo: TPanel;
    plnRodape: TPanel;
    btnImportar: TBitBtnLocked;
    btnSair: TBitBtnLocked;
    edtCaminhoArquivo: TFilenameEditFocus;
    lblPath: TLabel;
    btnInfor: TcxButton;
    pgbBarraProgresso: TcxProgressBar;
    pnlInfor: TPanel;
    pnlInfo: TPanel;
    pnlNomeForm: TPanel;
    cdsMetasVend: TUniClientDataSet;
    cdsMetasMarcaGrupo: TUniClientDataSet;
    cdsMetasVendMET_CODVEN: TStringField;
    cdsMetasVendMET_VALFAT: TFloatField;
    cdsMetasVendMET_VALFRE: TFloatField;
    cdsMetasVendMET_MARGEM: TFloatField;
    cdsMetasVendMET_MTATDI: TFloatField;
    cdsMetasVendMET_MTTKMD: TFloatField;
    cdsMetasVendMET_MTITDC: TFloatField;
    cdsMetasMarcaGrupoMET_CODOPE: TStringField;
    frxHelp: TfrxReport;
    procedure btnImportarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnInforClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    blnPorMarca: Boolean;
    objValidaExcel: TValidadorExcel;

    Const
      QUANTCOLUM = 12;

      COL_CODOPE = 'A';
      COL_VALFAT = 'B';
      COL_VALFRE = 'C';
      COL_MARGEM = 'D';
      COL_MTATDI = 'E';
      COL_MTTKMD = 'F';
      COL_MTITDC = 'G';
      COL_CODGRU = 'H';
      COL_DEFTIP = 'I';
      COL_PERGRU = 'J';
      COL_CODMAR = 'H';
      COL_PERMAR = 'I';

      DES_CODOPE = 'Código Operador';
      DES_VALFAT = 'Valor Faturamento';
      DES_VALFRE = 'Valor Frete';
      DES_MARGEM = 'Margem';
      DES_MTATDI = 'Meta Atend. Diário';
      DES_MTTKMD = 'Meta Ticket Médio';
      DES_MTITDC = 'Meta Itens por Doc.';
      DES_CODGRU = 'Código Linha/Grupo';
      DES_DEFTIP = 'Definição Linha/Grupo';
      DES_PERGRU = 'Percentual';
      DES_CODMAR = 'Código Marca';
      DES_PERMAR = 'Percentual';

    function fValidaArquivo: Boolean;
    function fExternaValidaValores(strValor: Variant; inLinhaAtual: Integer;
      var strMensagem: string): Boolean;
    function fExternaValidaTipoLinhaGrupo(strValor: Variant; inLinhaAtual: Integer;
      var strMensagem: string): Boolean;
    function fExternaValidaPercentual(strValor: Variant; inLinhaAtual: Integer;
      var strMensagem: string): Boolean;
    function fValidaPercentualMarcaGrupo(stlMarcaGrupo, stlPercentual: TStringList;
      strMarcaGrupo: String; var strMensagem: String): Boolean;
    function fValidaDadosArquivo: Boolean;
    function fTemTitulo: boolean;
    procedure pAtualizaInfoValidador;
    procedure pMontaObjValidador;
    procedure pImportaDadosMetas;
    procedure pPreencheCdsMetasMarcaGrupo(intLinha: Integer);
    procedure pPreencheCdsMetasVendedor(intLinha: Integer);
    procedure pCriaCdsMetasMarcaGrupo;
    procedure pCriaCdsMetasGrupo;
    procedure pCriaCdsMetasMarca;
    procedure pPreencheCdsMetasMarca(stlMarcas, stlPercentuais: TStringList;
      intLinha: Integer);
    procedure pPreencheCdsMetasGrupo(stlGrupos, stlPercentuais: TStringList;
      intLinha: Integer);
    function fExternaValidaCodigo(strValor: Variant; inLinhaAtual: Integer;
      var strMensagem: string): Boolean;
    function fValidaCodigoMarcaGrupo(stlMarcaGrupo: TStringList; strCampo,
      strTabela: String; var strMensagem: String): Boolean;

    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmImportacaoMetas.btnImportarClick(Sender: TObject);
begin
  If (Not fValidaArquivo) Then
  Begin
    pgbBarraProgresso.Position := 0;
    Exit;
  End;

  pImportaDadosMetas;
  ModalResult := MrOK;
end;

function TfrmImportacaoMetas.fValidaArquivo: Boolean;
begin
  Result := False;

  If (Not FileExists(edtCaminhoArquivo.Text)) Then
  Begin
    fMensagem('AVISO','Arquivo não encontrado: ' + edtCaminhoArquivo.Text + ' !', ['&OK']);
    Exit;
  End;

  If (Not fValidaDadosArquivo) Then
    Exit;

  Result := True;
end;

function TfrmImportacaoMetas.fValidaDadosArquivo: Boolean;
begin
  Result := False;

  pMontaObjValidador;

  If (objValidaExcel.intQtdLinhas = 0) Then
    Exit;

  If Not objValidaExcel.fValidaCampos(True, pgbBarraProgresso) Then
    Exit;

  Result := True;
end;

procedure TfrmImportacaoMetas.pMontaObjValidador;
begin
  objValidaExcel := TValidadorExcel.Create(edtCaminhoArquivo.text, QUANTCOLUM, COL_CODOPE, '', 0);
  objValidaExcel.FAtualizaStatus := pAtualizaInfoValidador;

  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(DES_CODOPE, COL_CODOPE, 3, True, True, 'CADOPE', 'OPE_CODOPE', True));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(DES_VALFAT, COL_VALFAT, True, fExternaValidaValores));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(DES_VALFRE, COL_VALFRE, True, fExternaValidaValores));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(DES_MARGEM, COL_MARGEM, True, fExternaValidaValores));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(DES_MTATDI, COL_MTATDI, True, fExternaValidaValores));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(DES_MTTKMD, COL_MTTKMD, True, fExternaValidaValores));
  objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoFloat(DES_MTITDC, COL_MTITDC, True, fExternaValidaValores));

  If blnPorMarca Then
  Begin
    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(DES_CODMAR, COL_CODMAR, 0, False, False, '', '', False, fExternaValidaCodigo));
    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(DES_PERMAR, COL_PERMAR, 0, False, False, '', '', False, fExternaValidaPercentual));
  End
  Else
  Begin
    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(DES_CODGRU, COL_CODGRU, 0, False, False, '', '', False, fExternaValidaCodigo));
    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(DES_DEFTIP, COL_DEFTIP, 0, False, False, '', '', False, fExternaValidaTipoLinhaGrupo));
    objValidaExcel.pAddCampo(objValidaExcel.fMontaCampoString(DES_PERGRU, COL_PERGRU, 0, False, False, '', '', False, fExternaValidaPercentual));
  End;
end;

procedure TfrmImportacaoMetas.pAtualizaInfoValidador;
begin
  pnlInfo.Caption := objValidaExcel.TempoExtimado;
end;

procedure TfrmImportacaoMetas.pImportaDadosMetas;
  Var
    intValIni: Integer;
    intContador: Integer;
begin
  intValIni := IIf(fTemTitulo, 1 , 0);
  pgbBarraProgresso.Properties.Max := objValidaExcel.ArquivoCSV.Count;
  pgbBarraProgresso.Position := 0;

  For intContador := intValIni To (objValidaExcel.ArquivoCSV.Count -1) Do
  Begin
    pnlInfo.Caption := 'Importando metas...'+ IntToStr(intContador) +'/' +
      IntToStr(objValidaExcel.ArquivoCSV.Count);

    If intContador > objValidaExcel.ArquivoCSV.Count Then
      Continue;

    pPreencheCdsMetasVendedor(intContador);
    pPreencheCdsMetasMarcaGrupo(intContador);

    pgbBarraProgresso.Position := pgbBarraProgresso.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TfrmImportacaoMetas.pPreencheCdsMetasVendedor(intLinha: Integer);
begin
  cdsMetasVend.Append;
  cdsMetasVend.FieldByName('MET_CODOPE').AsString := objValidaExcel.fGetValueCSV(intLinha, COL_CODOPE);
  cdsMetasVend.FieldByName('MET_VALFAT').AsFloat := StrToFloatDef(objValidaExcel.fGetValueCSV(intLinha, COL_VALFAT), 0);
  cdsMetasVend.FieldByName('MET_VALFRE').AsFloat := StrToFloatDef(objValidaExcel.fGetValueCSV(intLinha, COL_VALFRE), 0);
  cdsMetasVend.FieldByName('MET_MARGEM').AsFloat := StrToFloatDef(objValidaExcel.fGetValueCSV(intLinha, COL_MARGEM), 0);
  cdsMetasVend.FieldByName('MET_MTATDI').AsFloat := StrToFloatDef(objValidaExcel.fGetValueCSV(intLinha, COL_MTATDI), 0);
  cdsMetasVend.FieldByName('MET_MTTKMD').AsFloat := StrToFloatDef(objValidaExcel.fGetValueCSV(intLinha, COL_MTTKMD), 0);
  cdsMetasVend.FieldByName('MET_MTITDC').AsFloat := StrToFloatDef(objValidaExcel.fGetValueCSV(intLinha, COL_MTITDC), 0);
  cdsMetasVend.Post;
end;

procedure TfrmImportacaoMetas.pPreencheCdsMetasMarcaGrupo(intLinha: Integer);
  Var
    stlListMarcaGrupo: TStringList;
    stlListPercentual: TStringList;
begin
  stlListMarcaGrupo := TStringList.Create;
  stlListPercentual := TStringList.Create;

  Try
    Try
      If blnPorMarca Then
        pPreencheCdsMetasMarca(stlListMarcaGrupo, stlListPercentual, intLinha)
      Else
        pPreencheCdsMetasGrupo(stlListMarcaGrupo, stlListPercentual, intLinha);
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[pPreencheCdsMetasMarcaGrupo]');
    End;
  Finally
    FreeAndNil(stlListMarcaGrupo);
    FreeAndNil(stlListPercentual);
  End;
end;

procedure TfrmImportacaoMetas.pPreencheCdsMetasMarca(stlMarcas, stlPercentuais: TStringList; intLinha: Integer);
  Var
    intCont: Integer;
begin
  ExtractStrings(['/'], [], PChar(objValidaExcel.fGetValueCSV(intLinha, COL_CODMAR)), stlMarcas);
  ExtractStrings(['/'], [], PChar(objValidaExcel.fGetValueCSV(intLinha, COL_PERMAR)), stlPercentuais);

  For intCont := 0 To pred(stlMarcas.Count) Do
  Begin
    cdsMetasMarcaGrupo.Append;
    cdsMetasMarcaGrupo.FieldByName('MET_CODOPE').AsString := objValidaExcel.fGetValueCSV(intLinha, COL_CODOPE);
    cdsMetasMarcaGrupo.FieldByName('MET_CODMAR').AsString := stlMarcas[intCont];
    cdsMetasMarcaGrupo.FieldByName('MET_PERMAR').AsFloat  := StrToFloatDef(stlPercentuais[intCont], 0);
    cdsMetasMarcaGrupo.Post;
  End;
end;

procedure TfrmImportacaoMetas.pPreencheCdsMetasGrupo(stlGrupos, stlPercentuais: TStringList; intLinha: Integer);
  Var
    intCont: Integer;
    stlTipoGrupo: TStringList;
begin
  stlTipoGrupo := TStringList.Create;

  Try
    ExtractStrings(['/'], [], PChar(objValidaExcel.fGetValueCSV(intLinha, COL_CODGRU)), stlGrupos);
    ExtractStrings(['/'], [], PChar(objValidaExcel.fGetValueCSV(intLinha, COL_DEFTIP)), stlTipoGrupo);
    ExtractStrings(['/'], [], PChar(objValidaExcel.fGetValueCSV(intLinha, COL_PERGRU)), stlPercentuais);

    For intCont := 0 To pred(stlTipoGrupo.Count) Do
    Begin
      cdsMetasMarcaGrupo.Append;
      cdsMetasMarcaGrupo.FieldByName('MET_CODOPE').AsString := objValidaExcel.fGetValueCSV(intLinha, COL_CODOPE);
      cdsMetasMarcaGrupo.FieldByName('MET_CODGRU').AsString := stlGrupos[intCont];
      cdsMetasMarcaGrupo.FieldByName('MET_DEFTIP').AsString := stlTipoGrupo[intCont];
      cdsMetasMarcaGrupo.FieldByName('MET_PERGRU').AsFloat  := StrToFloatDef(stlPercentuais[intCont], 0);
      cdsMetasMarcaGrupo.Post;
    End;
  Finally
    FreeAndNil(stlTipoGrupo);
  End;
end;

procedure TfrmImportacaoMetas.pCriaCdsMetasMarcaGrupo;
begin
  If blnPorMarca Then
    pCriaCdsMetasMarca
  Else
    pCriaCdsMetasGrupo;
end;

procedure TfrmImportacaoMetas.pCriaCdsMetasMarca;
  Var
    objField: TField;
begin
  objField := TStringField.Create(cdsMetasMarcaGrupo);
  objField.FieldName := 'MET_CODMAR';
  objField.Name := 'cdsMetasMarcaGrupoMET_CODMAR';
  objField.DataSet := cdsMetasMarcaGrupo;

  objField := TFloatField.Create(cdsMetasMarcaGrupo);
  objField.FieldName := 'MET_PERMAR';
  objField.Name := 'cdsMetasMarcaGrupoMET_PERMAR';
  objField.DataSet := cdsMetasMarcaGrupo;

  cdsMetasMarcaGrupo.CreateDataSet;
end;

procedure TfrmImportacaoMetas.pCriaCdsMetasGrupo;
  Var
    objField: TField;
begin
  objField := TStringField.Create(cdsMetasMarcaGrupo);
  objField.FieldName := 'MET_CODGRU';
  objField.Name := 'cdsMetasMarcaGrupoMET_CODGRU';
  objField.DataSet := cdsMetasMarcaGrupo;

  objField := TStringField.Create(cdsMetasMarcaGrupo);
  objField.FieldName := 'MET_DEFTIP';
  objField.Name := 'cdsMetasMarcaGrupoMET_DEFTIP';
  objField.DataSet := cdsMetasMarcaGrupo;

  objField := TFloatField.Create(cdsMetasMarcaGrupo);
  objField.FieldName := 'MET_PERGRU';
  objField.Name := 'cdsMetasMarcaGrupoMET_PERGRU';
  objField.DataSet := cdsMetasMarcaGrupo;

  cdsMetasMarcaGrupo.CreateDataSet;
end;

function TfrmImportacaoMetas.fExternaValidaValores(strValor: Variant;
  inLinhaAtual: Integer; var strMensagem: string): Boolean;
begin
  Result := False;
  If (CompareValue(StrToFloatDef(strValor, 0), 0) = LessThanValue) Then
  Begin
    strMensagem := ' Valor não pode ser negativo.';
    Exit;
  End;
  Result := True;
end;

procedure TfrmImportacaoMetas.FormCreate(Sender: TObject);
begin
  blnPorMarca := fCfgSis('MTGRMA', varString) = 'M';
  pCriaCdsMetasMarcaGrupo;
end;

function TfrmImportacaoMetas.fExternaValidaTipoLinhaGrupo(strValor: Variant;
  inLinhaAtual: Integer; var strMensagem: string): Boolean;
  Var
    stlGrupos: TStringList;
    stlTipoGrupo: TStringList;
    intCont: Integer;
begin
  stlGrupos := TStringList.Create;
  stlTipoGrupo := TStringList.Create;

  Try
    Result := False;

    ExtractStrings(['/'], [], PChar(objValidaExcel.fGetValueCSV(inLinhaAtual, COL_CODGRU)), stlGrupos);
    ExtractStrings(['/'], [], PChar(objValidaExcel.fGetValueCSV(inLinhaAtual, COL_DEFTIP)), stlTipoGrupo);

    If (stlGrupos.Count <> stlTipoGrupo.Count) Then
    Begin
      strMensagem := ' Para cada código de grupo deve ser indicado um tipo de definição ("F" ou "M").';
      Exit;
    End;

    For intCont := 0 To pred(stlTipoGrupo.Count) Do
    Begin
      If (stlTipoGrupo[intCont] <> 'F') And (stlTipoGrupo[intCont] <> 'M')  Then
      Begin
        strMensagem := ' Tipo de definição de Linha/Grupo deve ser igual a "F" ou "M".';
        Exit;
      End;
    End;

    Result := True;
  Finally
    FreeAndNil(stlTipoGrupo);
    FreeAndNil(stlGrupos);
  End;
end;

function TfrmImportacaoMetas.fExternaValidaPercentual(strValor: Variant;
  inLinhaAtual: Integer; var strMensagem: string): Boolean;
  Var
    stlMarcaGrupo: TStringList;
    stlPercentual: TStringList;
    strMarcaGrupo: String;
begin
  stlMarcaGrupo := TStringList.Create;
  stlPercentual := TStringList.Create;
  Try
    Result := False;
    If blnPorMarca Then
    Begin
      ExtractStrings(['/'], [], PChar(objValidaExcel.fGetValueCSV(inLinhaAtual, COL_CODMAR)), stlMarcaGrupo);
      ExtractStrings(['/'], [], PChar(objValidaExcel.fGetValueCSV(inLinhaAtual, COL_PERMAR)), stlPercentual);
      strMarcaGrupo := 'Marca';
    End
    Else
    Begin
      ExtractStrings(['/'], [], PChar(objValidaExcel.fGetValueCSV(inLinhaAtual, COL_CODGRU)), stlMarcaGrupo);
      ExtractStrings(['/'], [], PChar(objValidaExcel.fGetValueCSV(inLinhaAtual, COL_PERGRU)), stlPercentual);
      strMarcaGrupo := 'Linha/Grupo';
    End;

    If (Not fValidaPercentualMarcaGrupo(stlMarcaGrupo, stlPercentual, strMarcaGrupo, strMensagem)) Then
      Exit;
  Finally
    FreeAndNil(stlMarcaGrupo);
    FreeAndNil(stlPercentual);
  End;
end;

function TfrmImportacaoMetas.fValidaPercentualMarcaGrupo(stlMarcaGrupo: TStringList;
  stlPercentual: TStringList; strMarcaGrupo: String; Var strMensagem: String): Boolean;
  Var
    intCont: Integer;
begin
  Result := False;

  If (stlMarcaGrupo.Count <> stlPercentual.Count) Then
  Begin
    strMensagem := ' Para cada '+ strMarcaGrupo +' deve ser atribuído um percentual.';
    Exit;
  End;

  For intCont := 0 To pred(stlPercentual.Count) Do
  Begin
    If (CompareValue(StrToFloatDef(stlPercentual[intCont], 0), 0) <> GreaterThanValue) Or
       (CompareValue(StrToFloatDef(stlPercentual[intCont], 0), 100) = GreaterThanValue) Then
    Begin
      strMensagem := ' Valor deve ser maior que 0 e menor ou igual a 100.';
      Exit;
    End;
  End;

  Result := True;
end;

procedure TfrmImportacaoMetas.btnInforClick(Sender: TObject);
begin
  frxHelp.DotMatrixReport           := False;
  frxHelp.PrintOptions.PrintMode    := pmScale;
  frxHelp.PrintOptions.PrintOnSheet := 9;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxHelp);
end;

procedure TfrmImportacaoMetas.btnSairClick(Sender: TObject);
begin
  Close;
end;

function TfrmImportacaoMetas.fExternaValidaCodigo(strValor: Variant;
  inLinhaAtual: Integer; var strMensagem: string): Boolean;
  Var
    stlMarcaGrupo: TStringList;
    strCampo: String;
    strTabela: String;
begin
  stlMarcaGrupo := TStringList.Create;

  Try
    Result := False;
    If blnPorMarca Then
    Begin
      ExtractStrings(['/'], [], PChar(objValidaExcel.fGetValueCSV(inLinhaAtual, COL_CODMAR)), stlMarcaGrupo);
      strCampo := 'MAR_CODMAR';
      strTabela := 'CADMAR';
    End
    Else
    Begin
      ExtractStrings(['/'], [], PChar(objValidaExcel.fGetValueCSV(inLinhaAtual, COL_CODGRU)), stlMarcaGrupo);
      strCampo := 'GRU_CODGRU';
      strTabela := 'CADGRU';
    End;

    If (Not fValidaCodigoMarcaGrupo(stlMarcaGrupo, strCampo, strTabela, strMensagem)) Then
      Exit;
  Finally
    FreeAndNil(stlMarcaGrupo);
  End;
end;

function TfrmImportacaoMetas.fValidaCodigoMarcaGrupo(stlMarcaGrupo: TStringList;
  strCampo: String; strTabela: String; Var strMensagem: String): Boolean;
  Var
    intCont: Integer;
begin
  Result := False;

  For intCont := 0 To pred(stlMarcaGrupo.Count) Do
  Begin
    If fEmptyStr(fCampoTabela(strCampo, strTabela, [strCampo], [stlMarcaGrupo[intCont]])) Then
    Begin
      strMensagem := ' Código '+ stlMarcaGrupo[intCont] + ' não encontrado.';
      Exit;
    End;
  End;

  Result := True;
end;

function TfrmImportacaoMetas.fTemTitulo: boolean;
  Var
    intValDef: Integer;
begin
  If objValidaExcel.fGetValueCSV(0, COL_CODOPE) <> '' Then
    Result := not TryStrToInt(Trim(objValidaExcel.fGetValueCSV(0, COL_CODOPE)), intValDef)
  Else
    Result := False;
end;

end.
