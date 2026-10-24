unit untImportarListaDeMateriais;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, UniClientDataSet,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, untImportarArquivoParaAnalise_de_Compras,
  cxDataStorage, cxEdit, cxNavigator, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, MemDS, DBAccess, Uni, Vcl.Samples.Gauges, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGridCitel, ClipBrd,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient,
  cxContainer, cxProgressBar,untZClient, cxCurrencyEdit, untTProcessaArquivo_Deceuninck_Kommerling;

type
  TDadosItemAutcom = Record

    Codigo     : String;
    Descricao  : String;
    Unidade    : String;
    CodUni     : String;
    Preco      : String;

    procedure Limpar;

  End;

type
  TDadoLinha = Record

    Linha         : String;
    CodigoFabrica : String;
    Descricao     : String;
    TotalMetragem : String;
    Posicao       : Integer;

    procedure Limpar;
    function fLeituraCodigoFabrica : String;
    function fLeituraDescricao     : String;
    function fLeituraTotalMetragem : String;


  End;

type
  TfrmImportarListaDeMateriais = class(TfrmPai)
    pnlCabecalho: TPanel;
    edtPath: TEdit;
    lblArquivo: TLabel;
    btnImportarArqTxt: TBitBtnLocked;
    dscDados: TDataSource;
    pnlCentro: TPanel;
    cxgListMat: TcxGrid;
    OpenDialog: TOpenDialog;
    btnImportar: TBitBtnLocked;
    cxgListMatDBBandedTableViewCitel1: TcxGridDBBandedTableViewCitel;
    cxgListMatDBBandedTableViewCitel1Column1: TcxGridDBBandedColumn;
    cxgListMatDBBandedTableViewCitel1Column2: TcxGridDBBandedColumn;
    cxgListMatDBBandedTableViewCitel1Column3: TcxGridDBBandedColumn;
    cxgListMatLevel: TcxGridLevel;
    cxgListMatDBBandedTableViewCitel2: TcxGridDBBandedTableViewCitel;
    rdgTipoLayout: TRadioGroup;
    cxgListMatDBBandedTableViewCitel2ARQ_CODFAB: TcxGridDBBandedColumn;
    cxgListMatDBBandedTableViewCitel2ARQ_DESITE: TcxGridDBBandedColumn;
    cxgListMatDBBandedTableViewCitel2ARQ_QTDITE: TcxGridDBBandedColumn;
    cxgListMatDBBandedTableViewCitel2ARQ_PRCITE: TcxGridDBBandedColumn;
    cxgListMatDBBandedTableViewCitel2AUT_CODITE: TcxGridDBBandedColumn;
    cxgListMatDBBandedTableViewCitel2AUT_DESITE: TcxGridDBBandedColumn;
    cxgListMatDBBandedTableViewCitel2AUT_UNIDAD: TcxGridDBBandedColumn;
    cxgListMatDBBandedTableViewCitel2AUT_QTDITE: TcxGridDBBandedColumn;
    cxgListMatDBBandedTableViewCitel2AUT_PRCITE: TcxGridDBBandedColumn;
    cxgListMatDBBandedTableViewCitel2AUT_SALDIS: TcxGridDBBandedColumn;
    cxgListMatDBBandedTableViewCitel2IDENTIFICADO: TcxGridDBBandedColumn;
    ggProcessamento: TcxProgressBar;
    Panel1: TPanel;
    lblParaLocalizar: TLabel;
    lblRemover: TLabel;
    lblNaoLocalizado: TLabel;
    Label5: TLabel;
    Shape3: TShape;
    shpNaoLocalizado: TShape;
    procedure btnImportarArqTxtClick(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgListMatDBBandedTableViewCitel2CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure cxgListMatDBBandedTableViewCitel2DblClick(Sender: TObject);
  private
    cdsExterno: TZClient;
    blnDestroyProcessaArquivo : Boolean;
    procedure pImportaArq(strPath : String);
    procedure pInsereMaterial(recLinha : TDadoLinha);
    function  fLocalizaItem(strCodigo : String;
                            strTipCod : String = 'F') : TDadosItemAutcom;
    function  fRetTotLinha(strPath : String) : Integer;
    function fPesquisarItem: String;

  public
    cdsDados: TUniClientDataSet;
    strTabPre : String;
    ProcessaArquivo : TProcessaArquivo;
    procedure pImportarArquivo(strPath: string; AProgress: TcxProgressBar; AcdsExterno: TZClient; AProcessaArquivo : TProcessaArquivo);
  end;

var
  frmImportarListaDeMateriais: TfrmImportarListaDeMateriais;

implementation

uses
  untFuncoesSimples, EditFocus, untTypesSistema, untReqEnvioMatVidro,
  untPanelCxItem, untPnlDadosItem, untPesqItem;

{$R *.dfm}

procedure TfrmImportarListaDeMateriais.btnImportarClick(Sender: TObject);
var
  cdsClone : TUniClientDataSet;
begin

  inherited;

  cdsClone := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsClone, cdsDados);

  Try

    cdsClone.Filtered := False;
    cdsClone.Filter   := 'IDENTIFICADO = ' + QuotedStr('0');
    cdsClone.Filtered := True;

    If cdsClone.RecordCount > 0 Then
    Begin
      fMensagem('','Existe(m) item(ns) não localizado(s), você pode excluir ou localizar!', ['&OK']);
      Exit;
    End;

    If Assigned(ProcessaArquivo) Then
      ProcessaArquivo.pGravaITEFOR;

  Finally
    cdsClone.Destroy;
  End;

  ModalResult := mrOk;

end;

procedure TfrmImportarListaDeMateriais.btnImportarArqTxtClick(Sender: TObject);
begin

  inherited;

  If OpenDialog.Execute Then
    If (OpenDialog.FileName <> '') Then
    Begin
      blnDestroyProcessaArquivo := False;
      If Not Assigned(ProcessaArquivo) Then
      Begin
        ProcessaArquivo := TProcessaArquivo.Create(ggProcessamento, toListaMaterial);
        cdsDados := ProcessaArquivo.FqryDados;
        ProcessaArquivo.StrTabPreco := strTabPre;
        blnDestroyProcessaArquivo := True;
      End;

      edtPath.Text := OpenDialog.FileName;
      ProcessaArquivo.TipoLayout := IIf(rdgTipoLayout.ItemIndex = 0, tlDeceuninck, tlKommerling);
      dscDados.DataSet := ProcessaArquivo.FQryDados;
      ProcessaArquivo.Arquivo := edtPath.Text;
      If ProcessaArquivo.TipoLayout = tlDeceuninck  Then
      Begin
        If Not cdsDados.IsEmpty Then
        Begin
          cdsDados.First;
          btnImportar.Enabled := True;
        End
        Else
        Begin
          btnImportar.Enabled := False;
        End;
      End;
    End;

end;

procedure TfrmImportarListaDeMateriais.pInsereMaterial(recLinha: TDadoLinha);
begin
  cdsExterno.Append;
  cdsExterno.FieldByName('ARQ_CODFAB').AsString := recLinha.CodigoFabrica;
  cdsExterno.FieldByName('ARQ_DESITE').AsString := recLinha.Descricao;
 
  If ProcessaArquivo.TipoOrigem  = toAnaliseDeCompra Then
  Begin
    cdsExterno.FieldByName('QTDIMP').AsFloat  := fStrToFloat(recLinha.TotalMetragem);
    cdsExterno.FieldByName('ARQ_QTDITE').AsFloat  := fStrToFloat(recLinha.TotalMetragem);
  End
  Else
    cdsExterno.FieldByName('ARQ_QTDITE').AsFloat  := fStrToFloat(recLinha.TotalMetragem);
 
  cdsExterno.Post;
end;

procedure TfrmImportarListaDeMateriais.cxgListMatDBBandedTableViewCitel2CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin

  inherited;

  If Not cdsDados.Active Then
    Exit;

  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgListMatDBBandedTableViewCitel2IDENTIFICADO.Index]) =  tsiNaoEncontrado Then
  Begin

    If Not AViewInfo.Selected Then
      ACanvas.Font.Color := clRed;

  End;


  If Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgListMatDBBandedTableViewCitel2IDENTIFICADO.Index] = tsiDuplicado Then
      ACanvas.Font.Color := clBlue;

end;

procedure TfrmImportarListaDeMateriais.cxgListMatDBBandedTableViewCitel2DblClick(
  Sender: TObject);
begin
  inherited;
  ProcessaArquivo.pEscolheItensDuplicados;
end;

function TfrmImportarListaDeMateriais.fLocalizaItem(strCodigo : String;
                                                    strTipCod : String = 'F'): TDadosItemAutcom;
var
  qryAux : TUniQuery;
begin

  Result.Limpar;

  If fEmptyStr(strCodigo) Then
    Exit;

  If fEmptyStr(strTabPre) Then
    strTabPre := '1';

  qryAux := fCriaQuery();

  Try

    {Tenta localizar com "="}
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT');
    qryAux.SQL.Add('  CADITE.ITE_CODITE,');
    qryAux.SQL.Add('  CADITE.ITE_DESITE,');
    qryAux.SQL.Add('  CADUNI.UNI_SIGUNI,');
    qryAux.SQL.Add('  CADUNI.UNI_CODUNI,');
    qryAux.SQL.Add('  ITEGER.ITE_PREVE' + strTabPre + ' AS ITE_PREVEN');
    qryAux.SQL.Add('FROM');
    qryAux.SQL.Add('  CADITE');
    qryAux.SQL.Add('  INNER JOIN ITEGER ON (ITEGER.ITE_CODITE = CADITE.ITE_CODITE)');
    qryAux.SQL.Add('  LEFT  JOIN CADUNI ON (CADUNI.UNI_CODUNI = CADITE.ITE_CODUNI)');
    qryAux.SQL.Add('WHERE');

    {Fábrica}
    If strTipCod = 'F' Then
      qryAux.SQL.Add('  CADITE.ITE_CODFAB = :CODIGO AND')
    Else
    {Item}
    If strTipCod = 'I' Then
      qryAux.SQL.Add('  CADITE.ITE_CODITE = :CODIGO AND');
    qryAux.SQL.Add('  CADITE.ITE_ITEATI = "S" AND ');

    qryAux.SQL.Add('  ITEGER.ITE_CODEMP = :CODEMP');

    qryAux.ParamByName('CODIGO').AsString := strCodigo;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryAux.Open;

    If Not qryAux.IsEmpty Then
    Begin
      Result.Codigo    := qryAux.FieldByName('ITE_CODITE').AsString;
      Result.Descricao := qryAux.FieldByName('ITE_DESITE').AsString;
      Result.Unidade   := qryAux.FieldByName('UNI_SIGUNI').AsString;
      Result.Preco     := qryAux.FieldByName('ITE_PREVEN').AsString;
      Result.CodUni    := qryAux.FieldByName('UNI_CODUNI').AsString;
    End
    Else
    If (strTipCod = 'F') Then
    Begin

      {Tenta localizar com "Like"}
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT');
      qryAux.SQL.Add('  CADITE.ITE_CODITE,');
      qryAux.SQL.Add('  CADITE.ITE_DESITE,');
      qryAux.SQL.Add('  CADUNI.UNI_SIGUNI,');
      qryAux.SQL.Add('  CADUNI.UNI_CODUNI,');
      qryAux.SQL.Add('  ITEGER.ITE_PREVE' + strTabPre + ' AS ITE_PREVEN');
      qryAux.SQL.Add('FROM');
      qryAux.SQL.Add('  CADITE');
      qryAux.SQL.Add('  INNER JOIN ITEGER ON (ITEGER.ITE_CODITE = CADITE.ITE_CODITE)');
      qryAux.SQL.Add('  LEFT  JOIN CADUNI ON (CADUNI.UNI_CODUNI = CADITE.ITE_CODUNI)');
      qryAux.SQL.Add('WHERE');
      qryAux.SQL.Add('  CADITE.ITE_CODFAB LIKE (' + QuotedStr('%' + strCodigo + '%') + ') AND');
      qryAux.SQL.Add('  ITEGER.ITE_CODEMP = :CODEMP');
      qryAux.SQL.Add('  AND CADITE.ITE_ITEATI = "S" ');

      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

      qryAux.Open;

      {Considera apenas se 1 registro}
      If (qryAux.RecordCount = 1) Then
      Begin
        Result.Codigo    := qryAux.FieldByName('ITE_CODITE').AsString;
        Result.Descricao := qryAux.FieldByName('ITE_DESITE').AsString;
        Result.Unidade   := qryAux.FieldByName('UNI_SIGUNI').AsString;
        Result.Preco     := qryAux.FieldByName('ITE_PREVEN').AsString;
      End

    End;

  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TfrmImportarListaDeMateriais.FormDestroy(Sender: TObject);
begin
  inherited;
  If blnDestroyProcessaArquivo Then
    FreeAndNil(ProcessaArquivo);
end;

procedure TfrmImportarListaDeMateriais.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  strCodIte     : String;
  recItemAutcom : TDadosItemAutcom;
begin
  inherited;

  If (Key = VK_F12) Then
    btnImportar.Click
  Else
  If (Key = VK_RETURN) And (cxgListMatDBBandedTableViewCitel2.Focused) And (cdsDados.Active) And (Not cdsDados.IsEmpty) then
  Begin

    If cdsDados.FieldByName('IDENTIFICADO').AsInteger <> tsiNaoEncontrado  Then
    Begin
      If (fMensagem('AVISO!', 'Item já localizado automaticamente, deseja mesmo assim associar?', ['&Sim', '&Não']) = 2) Then
        Exit;
    End;

    strCodIte := fPesquisarItem;

    If Not fEmptyStr(strCodIte) Then
    Begin

      If Not cdsDados.IsEmpty Then
      Begin

        recItemAutcom := fLocalizaItem(strCodIte, 'I');

        If Not (fEmptyStr(recItemAutcom.Codigo)) Then
        Begin
          cdsDados.Edit;
          cdsDados.FieldByName('CODITE').AsString := recItemAutcom.Codigo;
          cdsDados.FieldByName('DESITE').AsString := recItemAutcom.Descricao;
          cdsDados.FieldByName('SIGUNI').AsString := recItemAutcom.Unidade;
          cdsDados.FieldByName('QTDIMP').AsFloat  := cdsDados.FieldByName('ARQ_QTDITE').AsFloat;
          cdsDados.FieldByName('AUT_PRCITE').AsFloat  := fStrToFloat(recItemAutcom.Preco);
          cdsDados.FieldByName('SALDIS').AsFloat  := fRetornaSaldoDisponivel(recItemAutcom.Codigo);
          cdsDados.Post;
        End

      End;

    End;

  End
  Else
  If (Key = VK_DELETE) And (cxgListMatDBBandedTableViewCitel2.Focused) And (cdsDados.Active) And (Not cdsDados.IsEmpty) then
  Begin
    If (fMensagem('AVISO!', 'Deseja realmente remover este item da importação?', ['&Sim', '&Não']) = 1) Then
      cdsDados.Delete;
  End;

end;

function TfrmImportarListaDeMateriais.fPesquisarItem: String;
Var
    intOpcAtivos: Integer;
    arrSel: TConsultasArray;
    objfrmPnl: TPanelCxItem;
    strTabPre: String;
    qryConIte: TUniQuery;
    strResult: String;
    Key: Char;
begin
  inherited;

  Try
    Key := '?';
    strResult := EmptyStr;
    qryConIte := fCriaQuery();
    strTabPre    := '1';
    intOpcAtivos := 3;

    objfrmPnl := TPanelCxItem.New();

    objFrmPnl.strNomForm := Self.Name;
    objFrmPnl.recParametros.strCodCli  := '';
    objFrmPnl.strCodVen  := '';
    objFrmPnl.strCodDig  := '';
    objFrmPnl.intPraMedio:= 0;
    objFrmPnl.recParametros.strTabPre  := '1';

    If fPesqItem(conIteCompleta,
                 Self,
                 Nil,
                 Nil,
                 qryConIte,
                 Key,
                 arrSel,
                 True,
                 objfrmPnl,
                 'Consulta de Itens',
                 strTabPre,
                 '',
                 0,
                 false,
                 false,
                 intOpcAtivos) Then

    Begin
      strResult := qryConIte.FieldByName('ITE_CODITE').AsString;
    End;

    Key := #0;
  finally
    FreeAndNil(qryConIte);
    Result := strResult;
  End;
end;

function TfrmImportarListaDeMateriais.fRetTotLinha(strPath: String): Integer;
Var
  txtArq   : TextFile;
  strLinha : String;
begin

  Result := 0;

  AssignFile(txtArq, strPath);
  Reset(txtArq);

  Try

    While (Not Eof(txtArq)) Do
    Begin
      Readln(txtArq, strLinha);
      Inc(Result);
    End;

  Finally
    CloseFile(txtArq);
  End;

end;

procedure TfrmImportarListaDeMateriais.pImportaArq(strPath: String);
Var
  txtArq         : TextFile;
  recLinha       : TDadoLinha;
  intTotalLinhas : Integer;
begin

  If fEmptyStr(strPath) Then
    Exit;

  If Not FileExists(strPath) Then
    Exit;

  {Limpar Dados}
  cdsDados.EmptyDataSet;

  intTotalLinhas := fRetTotLinha(strPath);
  ggProcessamento.Properties.Max := intTotalLinhas;
  ggProcessamento.Position := 0;
  ggProcessamento.Visible  := True;

  {Realiza Leitura do Arquivo}
  AssignFile(txtArq, strPath);
  Reset(txtArq);

  Try

    cxgListMat.BeginUpdate();

    While (Not Eof(txtArq)) Do
    Begin

      recLinha.Limpar;

      Readln(txtArq, recLinha.Linha);

      {Código de Fábrica}
      recLinha.CodigoFabrica := recLinha.fLeituraCodigoFabrica;

      {Descrição}
      recLinha.Descricao := recLinha.fLeituraDescricao;

      {Quantidade}
      recLinha.TotalMetragem := recLinha.fLeituraTotalMetragem;


      {Insere Material}
      pInsereMaterial(recLinha);

      ggProcessamento.Position:= ggProcessamento.Position + 1;
      Application.ProcessMessages;

    End;

    Flush(txtArq);

  Finally

    CloseFile(txtArq);
    ggProcessamento.Visible := False;
    cxgListMat.EndUpdate;

    If Not cdsDados.IsEmpty Then
    Begin
      cdsDados.First;
      btnImportar.Enabled := True;
    End
    Else
    Begin
      btnImportar.Enabled := False;
    End;

  End;

end;

procedure TfrmImportarListaDeMateriais.pImportarArquivo(strPath: string; AProgress: TcxProgressBar; AcdsExterno: TZClient; AProcessaArquivo : TProcessaArquivo);
begin
  If strPath <> '' Then
  Begin
   ggProcessamento := AProgress;
   cdsExterno := AcdsExterno;
   ProcessaArquivo := AProcessaArquivo;
   cdsDados := ProcessaArquivo.FqryDados;
   pImportaArq(strPath);
  End;
end;

{ TDadoLinha }

function TDadoLinha.fLeituraCodigoFabrica : String;
var
  i : Integer;
  strCodFabrica : String;
begin

  strCodFabrica := '';

  for i := Self.Posicao to Length(Self.Linha) do
  begin

    Inc(Self.Posicao);

    If (Self.Linha[i] = ' ') Then
      Break;

    If (Self.Linha[i] = '"') Then
    Begin
      Inc(Self.Posicao, 2);
      Break;
    End;

    strCodFabrica := strCodFabrica + Self.Linha[i];

  end;

  Result := Trim(strCodFabrica);

end;

function TDadoLinha.fLeituraDescricao: String;
var
  i : Integer;
  strDescricao : String;
begin

  strDescricao := '';

  for i := Self.Posicao to Length(Self.Linha) do
  begin

    Inc(Self.Posicao);

    If Self.Linha[i] = '"' Then
      Break;

    strDescricao := strDescricao + Self.Linha[i];

  end;

  Result := Trim(strDescricao);

end;

function TDadoLinha.fLeituraTotalMetragem: String;
var
  i : Integer;
  intQtdAspas: Integer;
  strQuantidade : String;
begin
  intQtdAspas := 0;
  For i := 0 To Length(Linha) Do
  begin
(* Arquivo Detalhes Linha
   +----------------------------------------------------------------------------------------+
   |Vazio |Codigo de Fabrica + Descricao |Preço Unitario|Qtde de unidades|Preço X quantidade|
   |----------------------------------------------------------------------------------------|
   |"",   |"1172654 Descricão Item",     |"38,11",      |"6,00",         |"228,66 "         |
   +----------------------------------------------------------------------------------------+
   12     3                      4       5     6         7    8           9                 *)

    If Self.Linha[i] = '"' Then
      inc(intQtdAspas);



    If intQtdAspas = 7 Then
      If Self.Linha[i] <> '"' Then
        strQuantidade :=  strQuantidade  + Linha[i];

    If intQtdAspas > 7 Then
      Break;
  end;

  Result := Trim(strQuantidade);

end;

procedure TDadoLinha.Limpar;
begin

  {Limpar campos do record}
  FillChar(Self, SizeOf(Self), #0);

  {Posição de leitura da linha}
  Self.Posicao := 5;

end;

{ TDadosItemAutcom }

procedure TDadosItemAutcom.Limpar;
begin
  {Limpar campos do record}
  FillChar(Self, SizeOf(Self), #0);
end;

end.
