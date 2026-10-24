unit untFatMostrarItensAplicacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, DB, cxDBData, cxGridLevel, cxGridCustomTableView, UniClientDataSet,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  cxCurrencyEdit, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatMostrarItensAplicacao = class(TfrmPai)
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
    ITE_APLICA: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxgrdDadosProdutosDBTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems0GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
      var AText: string);
    procedure cxgrdDadosProdutosDBTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems1GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
      var AText: string);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    cdsDados   : TUniClientDataSet;
    FcdsVendas : TUniClientDataSet;

    procedure pCriarClient;
  public
    { Public declarations }
    property cdsVendas: TUniClientDataSet Read FcdsVendas Write FcdsVendas;
  end;

var
  frmFatMostrarItensAplicacao: TfrmFatMostrarItensAplicacao;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmFatMostrarItensAplicacao }

procedure TfrmFatMostrarItensAplicacao.pCriarClient;
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
    Name := 'ITE_APLICA';
    DataType := ftString;
    Size := 50;
  End;

  cdsDados.CreateDataSet;
  cdsDados.IndexFieldNames := 'ITE_APLICA';
  cdsDados.EmptyDataSet;
end;

procedure TfrmFatMostrarItensAplicacao.cxgrdDadosProdutosDBTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems0GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: string);
begin
  inherited;

  If AValue <> Null Then
    AText := FormatFloat('#,###0.00', (AValue / 2));
end;

procedure TfrmFatMostrarItensAplicacao.cxgrdDadosProdutosDBTableView1TcxGridDBDataControllerTcxDataSummaryFooterSummaryItems1GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: string);
begin
  inherited;

  If AValue <> Null Then
    AText := FormatFloat('#,###0.00', (AValue / 2));
end;

procedure TfrmFatMostrarItensAplicacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(cdsDados);
end;

procedure TfrmFatMostrarItensAplicacao.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If Key = #27 Then
    Close;
end;

procedure TfrmFatMostrarItensAplicacao.FormShow(Sender: TObject);
  Var
    strUltAplica: String;
    fltUnitar,
    fltTotite: Double;
    cdsTmp: TUniClientDataSet;
    
  procedure pAddTotais;
  Begin
    With cdsDados Do
    Begin
      Append;
      FieldByName('ITE_UNITAR').AsFloat  := fltUnitar;
      FieldByName('ITE_TOTITE').AsFloat  := fltTotite;
      FieldByName('ITE_APLICA').AsString := strUltAplica;
      Post;
    End;
  End;

  procedure pAddItem;
  Begin
    With cdsTmp Do
    Begin
      cdsDados.Append;
      cdsDados.FieldByName('ITE_CODITE').AsString := FieldByName('ITE_CODITE').AsString;
      cdsDados.FieldByName('ITE_DESITE').AsString := FieldByName('ITE_DESITE').AsString;
      cdsDados.FieldByName('ITE_ENTSAI').AsString := FieldByName('ITE_ENTSAI').AsString;
      cdsDados.FieldByName('UNI_SIGUNI').AsString := FieldByName('ITE_SIGUNI').AsString;
      cdsDados.FieldByName('ITE_QTDITE').AsFloat  := FieldByName('ITE_QTDITE').AsFloat;
      cdsDados.FieldByName('ITE_UNITAR').AsFloat  := FieldByName('ITE_UNITAR').AsFloat;
      cdsDados.FieldByName('ITE_TOTITE').AsFloat  := (FieldByName('ITE_QTDITE').AsFloat *
                                                      FieldByName('ITE_UNITAR').AsFloat);
      cdsDados.FieldByName('ITE_APLICA').AsString := FieldByName('ITE_APLICA').AsString;
      cdsDados.Post;
    End;
  End;
begin
  inherited;

  Try
    pCriarClient;

    cdsTmp := TUniClientDataSet.Create(Self);;
    pCloneDataSet(cdsTmp, cdsVendas);
    cdsTmp.IndexFieldNames := 'ITE_APLICA';
    cdsTmp.Close;
    cdsTmp.Open;

    With cdsTmp Do
    Begin
      If Not IsEmpty Then
      Begin
        fltUnitar    := 0;
        fltTotite    := 0;

        First;
        strUltAplica := FieldByName('ITE_APLICA').AsString;

        While Not Eof Do
        Begin
          If SameText(strUltAplica, FieldByName('ITE_APLICA').AsString) Then
          Begin
            pAddItem;
            fltUnitar := fltUnitar + FieldByName('ITE_UNITAR').AsFloat;
            fltTotite := fltTotite + (FieldByName('ITE_QTDITE').AsFloat *
                                      FieldByName('ITE_UNITAR').AsFloat);
          End
          Else
          Begin
            pAddTotais;
            fltUnitar := 0;
            fltTotite := 0;
            strUltAplica := FieldByName('ITE_APLICA').AsString;

            pAddItem;
            fltUnitar := fltUnitar + FieldByName('ITE_UNITAR').AsFloat;
            fltTotite := fltTotite + (FieldByName('ITE_QTDITE').AsFloat *
                                      FieldByName('ITE_UNITAR').AsFloat);
          End;

          Next;
        End;

        pAddTotais;
      End;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmFatMostrarItensAplicacao.FormShow]');
  End;

  FreeAndNil(cdsTmp);
  dsDadosProdutos.DataSet := cdsDados;

  cxgrdDadosProdutosDBTableView1.ViewData.Expand(True);
  cxgrdDadosProdutosDBTableView1.DataController.Groups.FullExpand;
end;

end.
