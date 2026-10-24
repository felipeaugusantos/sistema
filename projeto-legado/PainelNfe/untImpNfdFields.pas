unit untImpNfdFields;

{
  Editor da impressao dinamica: campos (IMPNFE_FLD) de um dataset ou o SELECT
  (origem B).
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, DB, DBCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxTextEdit, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid,
  {$IFDEF VER300}
  cxDataControllerConditionalFormattingRulesManagerDialog,
  {$ENDIF}
  XMLIntf, XMLDoc,
{$IF Defined(UNIDAC)}
  Uni;
{$ELSE}
  ZConnection, ZDataset;
{$IFEND}

type
  TfrmImpNfdFields = class(TForm)
    pnlXml: TPanel;
    grdFld: TcxGrid;
    tbvFld: TcxGridDBTableView;
    tbvFldFLD_NOME: TcxGridDBColumn;
    tbvFldFLD_TIPO: TcxGridDBColumn;
    tbvFldFLD_CAMINH: TcxGridDBColumn;
    tbvFldFLD_CAMAUX: TcxGridDBColumn;
    tbvFldFLD_AJUSTE: TcxGridDBColumn;
    tbvFldFLD_DEFAUL: TcxGridDBColumn;
    lvlFld: TcxGridLevel;
    btnCarregarXml: TButton;
    tvXml: TTreeView;
    pnlCamposFld: TPanel;
    lblNome: TLabel;
    dbeNome: TDBEdit;
    lblTipo: TLabel;
    dbeTipo: TDBEdit;
    lblCaminho: TLabel;
    dbeCaminho: TDBEdit;
    lblCamAux: TLabel;
    dbeCamAux: TDBEdit;
    lblAjuste: TLabel;
    dbeAjuste: TDBEdit;
    lblDefault: TLabel;
    dbeDefault: TDBEdit;
    lblOrdem: TLabel;
    dbeOrdem: TDBEdit;
    lblFunc: TLabel;
    dbcFunc: TDBComboBox;
    lblColSel: TLabel;
    dbeColSel: TDBEdit;
    lblDica: TLabel;
    rgDestino: TRadioGroup;
    pnlBanco: TPanel;
    lblSelect: TLabel;
    pnlCamposSel: TPanel;
    dbmSelect: TDBMemo;
    btnCarregarCampos: TButton;
    lvPreview: TListView;
    btnSalvar: TButton;
    btnNovo: TButton;
    btnEditar: TButton;
    btnExcluir: TButton;
    btnCancelar: TButton;
    btnFechar: TButton;
    dtsFld: TDataSource;
    dtsSel: TDataSource;
    dlgXml: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dtsStateChange(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnCarregarXmlClick(Sender: TObject);
    procedure tvXmlDblClick(Sender: TObject);
    procedure btnCarregarCamposClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    qryFld: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    qrySel: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
    FDsAtual: TDataSet;
    // origem A com as colunas do script 003
    FblnModeloA: Boolean;
    procedure pConfiguraModeloA;
    function fCaminhoRelativo(const ACaminho: String): String;
    function fProximaOrdem(const ANomeAtual: String): Integer;
    procedure qryFldNewRecord(DataSet: TDataSet);
    procedure pAbrir(const ALocalizar: String = '');
    procedure pAjustaBotoes;
    procedure pHabilitaCampos(APainel: TWinControl; AHabilita: Boolean);
    function fModoBanco: Boolean;
    function fEmEdicao: Boolean;
    function fTemRegistro: Boolean;
    procedure pMontarArvoreXml(const AXml: String);
    procedure pAdicionarNoArvore(ANode: IXMLNode; ATreeNode: TTreeNode);
    function fCaminhoDoNo(ATreeNode: TTreeNode): String;
    function fNeutralizaMarcadores(const ASql: String): String;
  public
    NomePrv: String;   // chave do provedor (PRV_NOME)
    NomeCds: String;   // chave do cds dentro do provedor (CDS_NOMCDS)
    Origem: String;
    CamBas: String;    // caminho base do CDS (origem A)
  end;

var
  frmImpNfdFields: TfrmImpNfdFields;

implementation

uses
  untUtil, untNfsDinamico, untNfceDinamico;

{$R *.dfm}

{ TfrmImpNfdFields }

procedure TfrmImpNfdFields.FormCreate(Sender: TObject);
begin
  FDsAtual := nil;

  qryFld := fCriaQuery(Self);
  qryFld.SQL.Text :=
    'SELECT FLD_CODPRV, FLD_CODCDS, FLD_NOME, FLD_TIPO, FLD_CAMINH, FLD_CAMAUX, FLD_AJUSTE, FLD_DEFAUL ' +
    'FROM IMPNFE_FLD WHERE FLD_CODPRV = :PRV AND FLD_CODCDS = :CDS ORDER BY FLD_NOME';
{$IF Defined(UNIDAC)}
  qryFld.KeyFields := 'FLD_CODPRV;FLD_CODCDS;FLD_NOME';
{$IFEND}
  qryFld.OnNewRecord := qryFldNewRecord;
  dtsFld.DataSet := qryFld;

  qrySel := fCriaQuery(Self);
  qrySel.SQL.Text :=
    'SELECT CDS_CODPRV, CDS_NOMCDS, CDS_SELECT FROM IMPNFE_CDS ' +
    'WHERE CDS_CODPRV = :PRV AND CDS_NOMCDS = :CDS';
{$IF Defined(UNIDAC)}
  qrySel.KeyFields := 'CDS_CODPRV;CDS_NOMCDS';
{$IFEND}
  dtsSel.DataSet := qrySel;
end;

procedure TfrmImpNfdFields.FormShow(Sender: TObject);
begin
  Caption := 'Fields - ' + NomeCds + ' (origem ' + Origem + ')';
  pConfiguraModeloA;

  if fModoBanco then
  begin
    pnlXml.Visible   := False;
    pnlBanco.Visible := True;
    FDsAtual := qrySel;
  end
  else
  begin
    pnlBanco.Visible := False;
    pnlXml.Visible   := True;
    FDsAtual := qryFld;
  end;

  pAbrir;
end;

procedure TfrmImpNfdFields.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if fEmEdicao then
  begin
    if MessageDlg('Existem alterações não salvas. Deseja descartá-las e sair?',
         mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      FDsAtual.Cancel
    else
      CanClose := False;
  end;
end;

function TfrmImpNfdFields.fModoBanco: Boolean;
begin
  Result := SameText(Trim(Origem), 'B');
end;

procedure TfrmImpNfdFields.qryFldNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('FLD_CODPRV').AsString := NomePrv;
  DataSet.FieldByName('FLD_CODCDS').AsString := NomeCds;
end;

procedure TfrmImpNfdFields.pAbrir(const ALocalizar: String);
begin
  if fModoBanco then
  begin
    qrySel.Close;
    qrySel.ParamByName('PRV').AsString := NomePrv;
    qrySel.ParamByName('CDS').AsString := NomeCds;
    qrySel.Open;
  end
  else
  begin
    qryFld.Close;
    qryFld.ParamByName('PRV').AsString := NomePrv;
    qryFld.ParamByName('CDS').AsString := NomeCds;
    qryFld.Open;
    if ALocalizar <> '' then
      qryFld.Locate('FLD_NOME', ALocalizar, []);
  end;
  pAjustaBotoes;
end;

function TfrmImpNfdFields.fEmEdicao: Boolean;
begin
  Result := Assigned(FDsAtual) and (FDsAtual.State in [dsEdit, dsInsert]);
end;

function TfrmImpNfdFields.fTemRegistro: Boolean;
begin
  Result := Assigned(FDsAtual) and FDsAtual.Active and (not FDsAtual.IsEmpty);
end;

procedure TfrmImpNfdFields.pHabilitaCampos(APainel: TWinControl; AHabilita: Boolean);
var
  i: Integer;
begin
  for i := 0 to APainel.ControlCount - 1 do
  begin
    if APainel.Controls[i] is TLabel then
      Continue;

    // memo fica habilitado (para rolar/copiar), apenas somente-leitura fora da edicao
    if APainel.Controls[i] is TDBMemo then
    begin
      TDBMemo(APainel.Controls[i]).ReadOnly := not AHabilita;
      if AHabilita then
        TDBMemo(APainel.Controls[i]).Color := clWindow
      else
        TDBMemo(APainel.Controls[i]).Color := clBtnFace;
      Continue;
    end;

    APainel.Controls[i].Enabled := AHabilita;
  end;
end;

procedure TfrmImpNfdFields.pAjustaBotoes;
var
  blnEdicao, blnReg: Boolean;
begin
  if (csDestroying in ComponentState) or (not Assigned(FDsAtual)) then
    Exit;

  blnEdicao := fEmEdicao;
  blnReg    := fTemRegistro;

  btnSalvar.Enabled   := blnEdicao;
  btnCancelar.Enabled := blnEdicao;
  btnEditar.Enabled   := blnReg and (not blnEdicao);

  if fModoBanco then
  begin
    // registro unico (o proprio CDS): nao se inclui nem exclui por aqui
    btnNovo.Enabled    := False;
    btnExcluir.Enabled := False;
    pHabilitaCampos(pnlCamposSel, blnEdicao);
  end
  else
  begin
    btnNovo.Enabled    := FDsAtual.Active and (not blnEdicao);
    btnExcluir.Enabled := blnReg and (not blnEdicao);
    grdFld.Enabled     := not blnEdicao;
    pHabilitaCampos(pnlCamposFld, blnEdicao);
    // o nome do campo é chave (PK): só pode ser informado na inclusão
    dbeNome.Enabled := blnEdicao and (qryFld.State = dsInsert);
  end;
end;

procedure TfrmImpNfdFields.dtsStateChange(Sender: TObject);
begin
  pAjustaBotoes;
end;

procedure TfrmImpNfdFields.btnNovoClick(Sender: TObject);
begin
  if fModoBanco or fEmEdicao then
    Exit;
  qryFld.Append;
  dbeNome.SetFocus;
end;

procedure TfrmImpNfdFields.btnEditarClick(Sender: TObject);
begin
  if (not fTemRegistro) or fEmEdicao then
    Exit;
  FDsAtual.Edit;
  if fModoBanco then
    dbmSelect.SetFocus
  else
    dbeTipo.SetFocus;
end;

procedure TfrmImpNfdFields.btnCancelarClick(Sender: TObject);
begin
  if fEmEdicao then
    FDsAtual.Cancel;
end;

procedure TfrmImpNfdFields.btnSalvarClick(Sender: TObject);
var
  qry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  blnInserindo: Boolean;
  strNome: String;
  intQtd: Integer;
begin
  if not fEmEdicao then
    Exit;

  FDsAtual.UpdateRecord;

  strNome := '';
  blnInserindo := (FDsAtual.State = dsInsert);

  if not fModoBanco then
  begin
    strNome := Trim(qryFld.FieldByName('FLD_NOME').AsString);
    if fEmptyStr(strNome) then
    begin
      MessageDlg('Informe o nome do campo.', mtInformation, [mbOk], 0);
      dbeNome.SetFocus;
      Exit;
    end;

    // o nome do campo é chave: não pode repetir no dataset
    if blnInserindo then
    begin
      qry := fCriaQuery(Self);
      try
        qry.SQL.Text :=
          'SELECT COUNT(*) AS QTD FROM IMPNFE_FLD ' +
          'WHERE FLD_CODPRV = :PRV AND FLD_CODCDS = :CDS AND FLD_NOME = :NOME';
        qry.ParamByName('PRV').AsString  := NomePrv;
        qry.ParamByName('CDS').AsString  := NomeCds;
        qry.ParamByName('NOME').AsString := strNome;
        qry.Open;
        intQtd := qry.FieldByName('QTD').AsInteger;
        qry.Close;
      finally
        FreeAndNil(qry);
      end;

      if intQtd > 0 then
      begin
        MessageDlg('Já existe o campo "' + strNome + '" neste dataset.', mtInformation, [mbOk], 0);
        dbeNome.SetFocus;
        Exit;
      end;

      qryFld.FieldByName('FLD_NOME').AsString := strNome;
    end;

    // ordem em branco = ultima + 1
    if (qryFld.FindField('FLD_ORDEM') <> nil) and qryFld.FieldByName('FLD_ORDEM').IsNull then
      qryFld.FieldByName('FLD_ORDEM').AsInteger := fProximaOrdem(strNome);
  end;

  try
    FDsAtual.Post;
  except
    on E: Exception do
    begin
      MessageDlg('Não foi possível salvar.' + sLineBreak + E.Message, mtError, [mbOk], 0);
      Exit;
    end;
  end;

  pAbrir(strNome);
end;

procedure TfrmImpNfdFields.btnExcluirClick(Sender: TObject);
begin
  if fModoBanco or (not fTemRegistro) or fEmEdicao then
    Exit;

  if MessageDlg('Deseja realmente excluir o campo "' + qryFld.FieldByName('FLD_NOME').AsString + '"?',
       mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    Exit;

  qryFld.Delete;
  pAjustaBotoes;
end;

{ ------------------------- Origem A (Ambos) ------------------------- }

procedure TfrmImpNfdFields.pConfiguraModeloA;
var
  i: Integer;
begin
  FblnModeloA := SameText(Trim(Origem), 'A') and TNfsDinamico.fModeloNovoDisponivel;

  lblOrdem.Visible  := FblnModeloA;
  dbeOrdem.Visible  := FblnModeloA;
  lblFunc.Visible   := FblnModeloA;
  dbcFunc.Visible   := FblnModeloA;
  lblColSel.Visible := FblnModeloA;
  dbeColSel.Visible := FblnModeloA;

  if not FblnModeloA then
    Exit;

  dbeOrdem.DataField  := 'FLD_ORDEM';
  dbcFunc.DataField   := 'FLD_FUNC';
  dbeColSel.DataField := 'FLD_COLSEL';

  if SameText(NomePrv, cstProvedorCupomFiscal) then
    for i := Low(cstFuncoesNFCe) to High(cstFuncoesNFCe) do
      if dbcFunc.Items.IndexOf(cstFuncoesNFCe[i]) < 0 then
        dbcFunc.Items.Add(cstFuncoesNFCe[i]);

  qryFld.Close;
  qryFld.SQL.Text :=
    'SELECT FLD_CODPRV, FLD_CODCDS, FLD_NOME, FLD_TIPO, FLD_CAMINH, FLD_CAMAUX, FLD_AJUSTE, FLD_DEFAUL, ' +
    '       FLD_COLSEL, FLD_FUNC, FLD_ORDEM ' +
    'FROM IMPNFE_FLD WHERE FLD_CODPRV = :PRV AND FLD_CODCDS = :CDS ORDER BY FLD_ORDEM, FLD_NOME';
end;

function TfrmImpNfdFields.fCaminhoRelativo(const ACaminho: String): String;
var
  strBase, strCaminho, strSeg, strAlt: String;
  lstSeg: TStringList;
  intPos, i: Integer;
begin
  // origem A: com caminho base, o caminho fica relativo ao no do registro (no fora
  // da base vira absoluto "/..."); o grupo do ICMS/PIS/COFINS vira '*'
  Result := ACaminho;
  if not FblnModeloA then
    Exit;

  strCaminho := Trim(ACaminho);
  strBase := Trim(CamBas);
  if strBase <> '' then
  begin
    // alternativas separadas por "|": vale a primeira que casar
    intPos := 0;
    strAlt := '';
    while (intPos = 0) and (strBase <> '') do
    begin
      i := Pos('|', strBase);
      if i > 0 then
      begin
        strAlt := Trim(Copy(strBase, 1, i - 1));
        strBase := Trim(Copy(strBase, i + 1, MaxInt));
      end
      else
      begin
        strAlt := strBase;
        strBase := '';
      end;
      if strAlt <> '' then
        intPos := Pos('.' + UpperCase(strAlt) + '.', '.' + UpperCase(strCaminho));
    end;
    if intPos = 0 then
    begin
      if Pos('NFEPROC.', UpperCase(strCaminho)) = 1 then
        strCaminho := Copy(strCaminho, Length('nfeProc.') + 1, MaxInt);
      Result := '/' + strCaminho;
      Exit;
    end;
    strCaminho := Copy(strCaminho, intPos + Length(strAlt) + 1, MaxInt);
  end
  else if Pos('NFEPROC.', UpperCase(strCaminho)) = 1 then
    strCaminho := Copy(strCaminho, Length('nfeProc.') + 1, MaxInt);

  lstSeg := TStringList.Create;
  try
    while strCaminho <> '' do
    begin
      intPos := Pos('.', strCaminho);
      if intPos > 0 then
      begin
        lstSeg.Add(Copy(strCaminho, 1, intPos - 1));
        strCaminho := Copy(strCaminho, intPos + 1, MaxInt);
      end
      else
      begin
        lstSeg.Add(strCaminho);
        strCaminho := '';
      end;
    end;

    for i := 2 to lstSeg.Count - 1 do
    begin
      strSeg := lstSeg[i - 1];
      if SameText(lstSeg[i - 2], 'imposto') and
         (SameText(strSeg, 'ICMS') or SameText(strSeg, 'PIS') or SameText(strSeg, 'COFINS')) and
         (Length(lstSeg[i]) > Length(strSeg)) and
         SameText(Copy(lstSeg[i], 1, Length(strSeg)), strSeg) then
        lstSeg[i] := '*';
    end;

    Result := '';
    for i := 0 to lstSeg.Count - 1 do
    begin
      if Result <> '' then
        Result := Result + '.';
      Result := Result + lstSeg[i];
    end;
  finally
    FreeAndNil(lstSeg);
  end;
end;

function TfrmImpNfdFields.fProximaOrdem(const ANomeAtual: String): Integer;
var
  qry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  // maior FLD_ORDEM do dataset + 1, sem contar o proprio campo (edicao)
  qry := fCriaQuery(Self);
  try
    qry.SQL.Text :=
      'SELECT COALESCE(MAX(FLD_ORDEM), 0) + 1 AS PROXIMA FROM IMPNFE_FLD ' +
      'WHERE FLD_CODPRV = :PRV AND FLD_CODCDS = :CDS AND FLD_NOME <> :NOME';
    qry.ParamByName('PRV').AsString  := NomePrv;
    qry.ParamByName('CDS').AsString  := NomeCds;
    qry.ParamByName('NOME').AsString := ANomeAtual;
    qry.Open;
    Result := qry.FieldByName('PROXIMA').AsInteger;
    qry.Close;
  finally
    FreeAndNil(qry);
  end;
end;

{ ------------------------- Origem XML ------------------------- }

procedure TfrmImpNfdFields.btnCarregarXmlClick(Sender: TObject);
var
  lst: TStringList;
begin
  if not dlgXml.Execute then
    Exit;

  lst := TStringList.Create;
  try
    lst.LoadFromFile(dlgXml.FileName);
    pMontarArvoreXml(lst.Text);
  finally
    FreeAndNil(lst);
  end;
end;

procedure TfrmImpNfdFields.pMontarArvoreXml(const AXml: String);
var
  XmlDoc: IXMLDocument;
begin
  tvXml.Items.BeginUpdate;
  try
    tvXml.Items.Clear;
    XmlDoc := TXMLDocument.Create(nil);
    XmlDoc.LoadFromXML(AXml);
    XmlDoc.Active := True;
    if XmlDoc.DocumentElement <> nil then
      pAdicionarNoArvore(XmlDoc.DocumentElement, nil);
    tvXml.FullExpand;
  finally
    tvXml.Items.EndUpdate;
  end;
end;

procedure TfrmImpNfdFields.pAdicionarNoArvore(ANode: IXMLNode; ATreeNode: TTreeNode);
var
  i: Integer;
  strTexto, strNome: String;
  novoNo: TTreeNode;
begin
  if ANode = nil then
    Exit;

  strNome := ANode.LocalName;
  if strNome = '' then
    strNome := ANode.NodeName;

  strTexto := strNome;
  if (ANode.HasChildNodes) and (ANode.ChildNodes.Count = 1) and
     (ANode.ChildNodes[0].NodeType = ntText) then
    strTexto := strNome + ' = ' + ANode.Text;

  novoNo := tvXml.Items.AddChild(ATreeNode, strTexto);

  if ANode.HasChildNodes then
    for i := 0 to ANode.ChildNodes.Count - 1 do
      if ANode.ChildNodes[i].NodeType = ntElement then
        pAdicionarNoArvore(ANode.ChildNodes[i], novoNo);
end;

function TfrmImpNfdFields.fCaminhoDoNo(ATreeNode: TTreeNode): String;
var
  strNome: String;
  no: TTreeNode;
begin
  Result := '';
  no := ATreeNode;
  while no <> nil do
  begin
    strNome := no.Text;
    if Pos(' = ', strNome) > 0 then
      strNome := Copy(strNome, 1, Pos(' = ', strNome) - 1);

    if Result = '' then
      Result := strNome
    else
      Result := strNome + '.' + Result;

    no := no.Parent;
  end;
end;

procedure TfrmImpNfdFields.tvXmlDblClick(Sender: TObject);
var
  strCaminho: String;
begin
  if tvXml.Selected = nil then
    Exit;

  if qryFld.State in [dsEdit, dsInsert] then
  begin
    // rgDestino: 0 = Caminho, 1 = Caminho auxiliar
    strCaminho := fCaminhoRelativo(fCaminhoDoNo(tvXml.Selected));
    if strCaminho = '' then
    begin
      MessageDlg('Selecione uma tag dentro do caminho base do dataset (' + Trim(CamBas) + '). ' +
        'Os campos sao lidos a partir de cada registro desse caminho.', mtWarning, [mbOk], 0);
      Exit;
    end;

    if rgDestino.ItemIndex = 1 then
      qryFld.FieldByName('FLD_CAMAUX').AsString := strCaminho
    else
      qryFld.FieldByName('FLD_CAMINH').AsString := strCaminho;
  end
  else
    MessageDlg('Clique em Novo ou Editar para preencher o caminho do campo.',
      mtInformation, [mbOk], 0);
end;

{ ------------------------- Origem Banco ------------------------- }

function TfrmImpNfdFields.fNeutralizaMarcadores(const ASql: String): String;

  function EhIdent(c: Char): Boolean;
  begin
    Result := ((c >= 'A') and (c <= 'Z')) or
              ((c >= 'a') and (c <= 'z')) or
              ((c >= '0') and (c <= '9')) or (c = '_');
  end;

var
  i, len: Integer;
begin
  // troca todos os marcadores VS_<ident> por NULL apenas para previa das colunas
  Result := '';
  len := Length(ASql);
  i := 1;
  while i <= len do
  begin
    if (i + 2 <= len) and (UpperCase(Copy(ASql, i, 3)) = 'VS_') then
    begin
      Inc(i, 3);
      while (i <= len) and EhIdent(ASql[i]) do
        Inc(i);
      Result := Result + 'NULL';
    end
    else
    begin
      Result := Result + ASql[i];
      Inc(i);
    end;
  end;
end;

procedure TfrmImpNfdFields.btnCarregarCamposClick(Sender: TObject);
var
  qry: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
  it: TListItem;
  i: Integer;
begin
  // usa o texto que esta no editor (mesmo antes de salvar)
  if fEmptyStr(Trim(dbmSelect.Lines.Text)) then
  begin
    MessageDlg('Informe o SELECT.', mtInformation, [mbOk], 0);
    Exit;
  end;

  lvPreview.Items.BeginUpdate;
  try
    lvPreview.Items.Clear;
    qry := fCriaQuery(Self);
    try
      // previa: neutraliza os VS_* e limita a 0 linhas (so as colunas)
      qry.SQL.Text := 'SELECT X.* FROM (' + fNeutralizaMarcadores(dbmSelect.Lines.Text) + ') X WHERE 1 = 0';
      qry.Open;
      for i := 0 to qry.FieldCount - 1 do
      begin
        it := lvPreview.Items.Add;
        it.Caption := qry.Fields[i].FieldName;
        it.SubItems.Add(FieldTypeNames[qry.Fields[i].DataType]);
      end;
      qry.Close;
    finally
      FreeAndNil(qry);
    end;
  finally
    lvPreview.Items.EndUpdate;
  end;

  if lvPreview.Items.Count = 0 then
    MessageDlg('O SELECT não retornou colunas.', mtInformation, [mbOk], 0);
end;

procedure TfrmImpNfdFields.btnFecharClick(Sender: TObject);
begin
  Close;
end;

end.
