unit untFatMostrarItensAmbiente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, UniClientDataSet,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, DB, cxDBData, cxGridLevel, cxGridCustomTableView, DBClient,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  cxCurrencyEdit, untFuncFat, StrUtils, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, EditFocus, MemDS,
  DBAccess, Uni;

type
  TfrmFatMostrarItensAmbiente = class(TfrmPai)
    dsDadosProdutos: TDataSource;
    cxgrdDadosProdutos: TcxGrid;
    cxgrdDadosProdutosDBTableView1: TcxGridDBTableView;
    ITE_CODITE: TcxGridDBColumn;
    ITE_DESITE: TcxGridDBColumn;
    UNI_SIGUNI: TcxGridDBColumn;
    cxgrdlvlDadosProdutosLevel1: TcxGridLevel;
    ITE_QTDITE: TcxGridDBColumn;
    ITE_UNITAR: TcxGridDBColumn;
    ITE_TOTITE: TcxGridDBColumn;
    ITE_ENTSAI: TcxGridDBColumn;
    ITE_COMPLE: TcxGridDBColumn;
    ITE_DESMAR: TcxGridDBColumn;
    ITE_ENTRET: TcxGridDBColumn;
    ITE_MOTFUT: TcxGridDBColumn;
    ITE_CLIBUS: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxsGroup: TcxStyle;
    cxsHeader: TcxStyle;
    cxsFooter: TcxStyle;
    AUTOINCREM: TcxGridDBColumn;
    ITE_CODFAB: TcxGridDBColumn;
    ITE_REFERE: TcxGridDBColumn;
    ITE_TOTORI: TcxGridDBColumn;
    ITE_PERDES: TcxGridDBColumn;
    pnlRodape: TPanel;
    lblDesPro: TLabel;
    lblValFre: TLabel;
    lblProfisional: TLabel;
    edtValFre: TEditFocus;
    cdsProfissionais: TUniClientDataSet;
    cdsProfissionaisCODDIV: TStringField;
    cdsProfissionaisNOMDIV: TStringField;
    btnProfissionais: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnProfissionaisClick(Sender: TObject);
    procedure cxgrdDadosProdutosDBTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems2GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
      var AText: string);
  private
    { Private declarations }
    cdsDados   : TUniClientDataSet;
    FcdsVendas : TUniClientDataSet;
    FfatVenda  : TFatVenda;

    procedure pCriarClient;
    procedure pFormataDecimaisGrid;
    function fBuscaProfissionais: integer;
    procedure pCalculaMediaPorAmbiente;
  public
    { Public declarations }
    property cdsVendas: TUniClientDataSet Read FcdsVendas Write FcdsVendas;
    property fatVenda : TFatVenda Read FfatVenda  Write FfatVenda;
  end;

var
  frmFatMostrarItensAmbiente: TfrmFatMostrarItensAmbiente;

implementation

uses untFuncoesSimples, untObservacao;

{$R *.dfm}

{ TfrmFatMostrarItensAmbiente }



procedure TfrmFatMostrarItensAmbiente.btnProfissionaisClick(Sender: TObject);
var
  frmObservacaoLocal: TfrmObservacao;
  strMensagem: string;
begin
  inherited;
  pCriarFormularios(TfrmObservacao, frmObservacaoLocal);

  try
    strMensagem := EmptyStr;
  
    cdsProfissionais.First;
    while not cdsProfissionais.Eof do
    begin
      strMensagem := strMensagem + cdsProfissionaisCODDIV.AsString + ' - ' + cdsProfissionaisNOMDIV.AsString + sLineBreak;  
      cdsProfissionais.Next;
    end;
  
  
    frmObservacaoLocal.lblMensagem.caption := 'Profissionais da venda';
    frmObservacaoLocal.memObs.Texto :=  strMensagem;
    frmObservacaoLocal.ShowModal;  
  finally
    pFreeAndNil(frmObservacaoLocal);
  end;

end;

procedure TfrmFatMostrarItensAmbiente.cxgrdDadosProdutosDBTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems2GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: string);
var
  fltDesc: Double;
begin
  inherited;
  if cxgrdDadosProdutosDBTableView1.DataController.Summary.FooterSummaryValues[0] = Null then
    Exit;

  if cxgrdDadosProdutosDBTableView1.DataController.Summary.FooterSummaryValues[1] = Null then
    Exit;


  fltDesc := (100 - ((cxgrdDadosProdutosDBTableView1.DataController.Summary.FooterSummaryValues[0] * 100) / cxgrdDadosProdutosDBTableView1.DataController.Summary.FooterSummaryValues[1]));
  AText := FloatToStrF(fltDesc, ffFixed, 5, 2);
end;

function TfrmFatMostrarItensAmbiente.fBuscaProfissionais: integer;
var
  qryProfissionais: TUniQuery;
  strAutInc: string;
begin
  qryProfissionais := fCriaQuery;
  
  try
    qryProfissionais.Close;
    qryProfissionais.SQL.Clear;
    qryProfissionais.SQL.Add('SELECT AUTOINCREM');
    qryProfissionais.SQL.Add('FROM FATGOR');
    qryProfissionais.SQL.Add('WHERE FGO_NUMDOC = :NUMDOC');
    qryProfissionais.SQL.Add('AND FGO_ESPDOC = :ESPDOC');
    qryProfissionais.SQL.Add('AND FGO_CODEMP = :CODEMP');
    qryProfissionais.ParamByName('NUMDOC').AsString := fatVenda.strNumOrc;
    qryProfissionais.ParamByName('ESPDOC').AsString := fatVenda.strEspOrc;
    qryProfissionais.ParamByName('CODEMP').AsString := fatVenda.strEmpDoc;
    qryProfissionais.Open; 
    
    if not qryProfissionais.IsEmpty then
    begin
      strAutInc := qryProfissionais.FieldByName('AUTOINCREM').AsString;

      qryProfissionais.Close;
      qryProfissionais.SQL.Clear;
      qryProfissionais.SQL.Add('SELECT DIV_CODDIV');
      qryProfissionais.SQL.Add('FROM DIVFAT');
      qryProfissionais.SQL.Add('WHERE DIV_SEQGER = :SEQGER');
      qryProfissionais.ParamByName('SEQGER').AsString := strAutInc;
      qryProfissionais.Open; 

      if qryProfissionais.IsEmpty then
      begin
        qryProfissionais.Close;
        qryProfissionais.SQL.Clear;
        qryProfissionais.SQL.Add('SELECT FDO_CODDIV');
        qryProfissionais.SQL.Add('FROM FATDOR');
        qryProfissionais.SQL.Add('WHERE FDO_SEQGER = :SEQGER');
        qryProfissionais.ParamByName('SEQGER').AsString := strAutInc;
        qryProfissionais.Open;   

        if (not qryProfissionais.IsEmpty) then
        begin
          if (not fEmptyStr(qryProfissionais.FieldByName('FDO_CODDIV').AsString)) then
          begin
            cdsProfissionais.Append;
            cdsProfissionaisCODDIV.AsString := qryProfissionais.FieldByName('FDO_CODDIV').AsString;
            cdsProfissionaisNOMDIV.AsString := fRetNomProfissional(qryProfissionais.FieldByName('FDO_CODDIV').AsString);
            cdsProfissionais.Post;
          end;
        end;
      end
      else
      begin
        while not qryProfissionais.Eof do
        begin
          cdsProfissionais.Append;
          cdsProfissionaisCODDIV.AsString := qryProfissionais.FieldByName('DIV_CODDIV').AsString;
          cdsProfissionaisNOMDIV.AsString := fRetNomProfissional(qryProfissionais.FieldByName('DIV_CODDIV').AsString);
          cdsProfissionais.Post;
          qryProfissionais.Next;
        end;
      end;   
    end;

  finally
    FreeAndNil(qryProfissionais);
    Result := cdsProfissionais.RecordCount;
  end;
end;

procedure TfrmFatMostrarItensAmbiente.pCalculaMediaPorAmbiente;
var
  intIndice: integer;
  fltDesc: Double;
begin

  for intIndice := 0 to cxgrdDadosProdutosDBTableView1.DataController.Groups.ChildCount[0] do
  begin
    fltDesc := (100 - ((cxgrdDadosProdutosDBTableView1.DataController.Summary.GroupSummaryValues[intIndice,0] * 100) / cxgrdDadosProdutosDBTableView1.DataController.Summary.GroupSummaryValues[intIndice,2]));
    cxgrdDadosProdutosDBTableView1.DataController.Summary.GroupSummaryValues[intIndice, 4] := FloatToStrF(fltDesc, ffFixed, 5, 2);
  end;
end;

procedure TfrmFatMostrarItensAmbiente.pCriarClient;
begin
  cdsDados := TUniClientDataSet.Create(Self);

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_CODITE';
    DataType := ftString;
    Size := 8;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_DESITE';
    DataType := ftString;
    Size := 70;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_ENTSAI';
    DataType := ftString;
    Size := 1;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name := 'UNI_SIGUNI';
    DataType := ftString;
    Size := 4;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_QTDITE';
    DataType := ftFloat;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_UNITAR';
    DataType := ftFloat;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_TOTITE';
    DataType := ftFloat;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_COMPLE';
    DataType := ftString;
    Size := 50;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_DESMAR';
    DataType := ftString;
    Size := 50;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_ENTRET';
    DataType := ftString;
    Size := 01;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_MOTFUT';
    DataType := ftString;
    Size := 01;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_CLIBUS';
    DataType := ftString;
    Size := 01;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name := 'AUTOINCREM';
    DataType := ftInteger;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_CODFAB';
    DataType := ftString;
    Size := 35;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_REFERE';
    DataType := ftString;
    Size := 30;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_TOTORI';
    DataType := ftFloat;
  End;

  With cdsDados.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_PERDES';
    DataType := ftFloat;
  End;

  cdsDados.CreateDataSet;
  cdsDados.IndexFieldNames := 'ITE_COMPLE;AUTOINCREM';
  cdsDados.EmptyDataSet;
end;

procedure TfrmFatMostrarItensAmbiente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(cdsDados);
end;

procedure TfrmFatMostrarItensAmbiente.FormCreate(Sender: TObject);
begin
  inherited;
  cdsProfissionais.CreateDataSet;
end;

procedure TfrmFatMostrarItensAmbiente.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #27 Then
    Close;
end;

procedure TfrmFatMostrarItensAmbiente.FormShow(Sender: TObject);
  Var
    cdsTmp: TUniClientDataSet;
    intTotPro: integer;

  procedure pAddItem;
  Begin
    With cdsTmp Do
    Begin
      cdsDados.Append;
      cdsDados.FieldByName('ITE_CODITE').AsString  := FieldByName('ITE_CODITE').AsString;
      cdsDados.FieldByName('ITE_DESITE').AsString  := FieldByName('ITE_DESITE').AsString;
      cdsDados.FieldByName('ITE_ENTSAI').AsString  := FieldByName('ITE_ENTSAI').AsString;
      cdsDados.FieldByName('UNI_SIGUNI').AsString  := FieldByName('ITE_SIGUNI').AsString;
      cdsDados.FieldByName('ITE_QTDITE').AsFloat   := FieldByName('ITE_QTDITE').AsFloat;
      cdsDados.FieldByName('ITE_UNITAR').AsFloat   := FieldByName('ITE_UNITAR').AsFloat;
      cdsDados.FieldByName('ITE_TOTITE').AsFloat   := (FieldByName('ITE_QTDITE').AsFloat *
                                                       FieldByName('ITE_UNITAR').AsFloat);
      cdsDados.FieldByName('ITE_COMPLE').AsString  := FieldByName('ITE_COMPLE').AsString;
      cdsDados.FieldByName('ITE_DESMAR').AsString  := fRetNomMarcaItem(FieldByName('ITE_CODITE').AsString);
      cdsDados.FieldByName('ITE_ENTRET').AsString  := IIF(FieldByName('ITE_ENTFUT').AsString = 'S', 'F', IIF(FieldByName('ITE_ENTRET').AsString = 'E', 'I', 'R'));
      cdsDados.FieldByName('ITE_MOTFUT').AsString  := FieldByName('ITE_MOTFUT').AsString;
      cdsDados.FieldByName('ITE_CLIBUS').AsString  := FieldByName('ITE_CLIBUS').AsString;
      cdsDados.FieldByName('AUTOINCREM').AsInteger := FieldByName('AUTOINCREM').AsInteger;
      cdsDados.FieldByName('ITE_CODFAB').AsString  := FieldByName('ITE_CODFAB').AsString;
      cdsDados.FieldByName('ITE_REFERE').AsString  := FieldByName('ITE_REFERE').AsString;
      cdsDados.FieldByName('ITE_TOTORI').AsFloat   := (FieldByName('ITE_UNIORI').AsFloat * FieldByName('ITE_QTDITE').AsFloat);
      cdsDados.FieldByName('ITE_PERDES').AsFloat   := (((FieldByName('ITE_UNIORI').AsFloat - FieldByName('ITE_UNITAR').AsFloat) * 100) / FieldByName('ITE_UNIORI').AsFloat);
      cdsDados.Post;
    End;
  End;

begin
  inherited;

  Try
    pCriarClient;

    cdsTmp := TUniClientDataSet.Create(Self);;
    pCloneDataSet(cdsTmp, cdsVendas);
    cdsTmp.IndexFieldNames := 'ITE_COMPLE;AUTOINCREM;ITE_DESITE;';
    cdsTmp.Close;
    cdsTmp.Open;

    With cdsTmp Do
    Begin
      If Not IsEmpty Then
      Begin
        First;
        While Not Eof Do
        Begin
          pAddItem;
          Next;
        End;
      End;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmFatMostrarItensAmbiente.FormShow]');
  End;

  pFormataDecimaisGrid;

  FreeAndNil(cdsTmp);
  dsDadosProdutos.DataSet := cdsDados;

  cxgrdDadosProdutosDBTableView1.ViewData.Expand(True);
  cxgrdDadosProdutosDBTableView1.DataController.Groups.FullExpand;

  if not fEmptyStr(fatVenda.strEspOrc) then
  begin
    pnlRodape.Visible := True;
    edtValFre.Text := FormatFloat('#0.00', fatVenda.fltValFre);
    intTotPro := fBuscaProfissionais;
    if intTotPro > 0 then
    begin
      cdsProfissionais.First;
      lblProfisional.Caption := cdsProfissionaisCODDIV.AsString + ' - ' + cdsProfissionaisNOMDIV.AsString;

      if intTotPro > 2 then
      begin
        btnProfissionais.Visible := True;
      end;
    end;    
  end;

  pCalculaMediaPorAmbiente;
end;

procedure TfrmFatMostrarItensAmbiente.pFormataDecimaisGrid;
begin
  With cdsDados Do
  Begin
    (FieldByName('ITE_QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    (FieldByName('ITE_UNITAR') As TFloatField).DisplayFormat := fMskDigitos(fatVenda.VS_intDecUni);
    (FieldByName('ITE_TOTITE') As TFloatField).DisplayFormat := fMskDigitos(2);
    (FieldByName('ITE_TOTORI') As TFloatField).DisplayFormat := fMskDigitos(fatVenda.VS_intDecUni);
    (FieldByName('ITE_PERDES') As TFloatField).DisplayFormat := fMskDigitos(2);
  End;
end;

end.
