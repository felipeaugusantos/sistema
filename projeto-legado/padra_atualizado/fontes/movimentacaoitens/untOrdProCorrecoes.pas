unit untOrdProCorrecoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Grids,
  DBGridCitel, DBGrids, Uni, Mask, DB, AppEvnts, untOrdPro, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, QColorLabel, System.UITypes, System.Math,
  UniClientDataSet, untZClient, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxRadioGroup;

type
  TRetornoSaldo = (rsOk, rsErroLote, rsErroSaldo);
  TfrmOrdProCorrecoes = class(TfrmPai)
    pnlCentral: TPanel;
    pnlProdutos: TPanel;
    Label1: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    edtDesProduto: TEditFocus;
    edtProdutos: TEditFocus;
    edtReferencia: TEditFocus;
    edtUnidade: TEditFocus;
    lblInfoDel: TLabel;
    btnConfirma: TBitBtnLocked;
    lblCodFabrica: TLabel;
    edtCodFab: TEditFocus;
    cxGridDadosDBTableView: TcxGridDBTableView;
    cxGridDadosLevel1: TcxGridLevel;
    cxGridDados: TcxGrid;
    cxGridDadosDBTableViewCODITE: TcxGridDBColumn;
    cxGridDadosDBTableViewDESITE: TcxGridDBColumn;
    cxGridDadosDBTableViewCODFAB: TcxGridDBColumn;
    cxGridDadosDBTableViewQTDITE: TcxGridDBColumn;
    cxGridDadosDBTableViewREFERE: TcxGridDBColumn;
    cxGridDadosDBTableViewDESFAS: TcxGridDBColumn;
    cxGridDadosDBTableViewITE_DESTIN: TcxGridDBColumn;
    btnMarTodosEstoque: TBitBtnLocked;
    btnMarTodosRefugo: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxGridDadosDBTableViewCustomDrawGroupCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
    procedure btnMarTodosRefugoClick(Sender: TObject);
    procedure btnMarTodosEstoqueClick(Sender: TObject);
  private
    FCdsCorrecoes: TZClient;
    FStrCodPro: String;
    FBlnMontaCds: Boolean;
    FBlnDefinirDestino: Boolean;

    Function fGetSQL: String;

    procedure pDeletaItem;
    procedure pMarcarTodosEstoque;
    procedure pMarcarTodosRefugo;
  public
    { Public declarations }
    blnApenasValida : Boolean;
    blnConfirma : Boolean;
    objOrdPro: TOrdPro;
    fltQtdApr : Double;
    PossuiSaldo : Boolean;
    blnStateDataSetInsertEdit: Boolean;
    strAutIncFase: String;
    cdsSubProdJaVinculados: TUniClientDataSet;
    function fPossuiCorrecoes: Boolean;
  published
    property cdsCorrecoes: TZClient read FCdsCorrecoes;
    property strCodPro: String read FStrCodPro write FStrCodPro;
    property blnMontarCds: Boolean write FBlnMontaCds;
    property blnDefinirDestino: Boolean write FBlnDefinirDestino;

  end;

var
  frmOrdProCorrecoes: TfrmOrdProCorrecoes;

implementation

uses untfuncoesSimples, untPesqAux, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmOrdProCorrecoes.FormShow(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  pSetaCodIte( edtProdutos );

  If FBlnMontaCds Then
  Begin
    FCdsCorrecoes.Close;
    FCdsCorrecoes.qryQuery.SQL.Clear;
    FCdsCorrecoes.qryQuery.SQL.Add(fGetSQL);
    FCdsCorrecoes.fAbreClient(True, 'TfrmOrdProCorrecoes.FormCreate');
    cxGridDadosDBTableView.DataController.DataSource := FCdsCorrecoes.dtsSource;
    FBlnMontaCds := False;
  End;

  If FBlnDefinirDestino Then
  Begin
    cxGridDadosDBTableViewDESFAS.GroupIndex := -1;
    FCdsCorrecoes.Filter := 'ITE_EXCLUI = ''S''';
    FCdsCorrecoes.Filtered := True;
    FCdsCorrecoes.First;

    btnMarTodosEstoque.Click;

    cxGridDadosDBTableViewITE_DESTIN.Visible := True;
    Caption := 'Destino dos produtos excluídos da OP';
    btnMarTodosEstoque.Visible := True;
    btnMarTodosRefugo.Visible := True;
    lblInfoDel.Visible := False;
    btnConfirma.Visible := True;
    FBlnDefinirDestino := False;
  End
  Else
  Begin
    cxGridDadosDBTableViewDESFAS.GroupIndex := 0;
    FCdsCorrecoes.Filter := 'ITE_EXCLUI = ''N''';
    FCdsCorrecoes.Filtered := True;
    FCdsCorrecoes.First;
    cxGridDadosDBTableViewITE_DESTIN.Visible := False;
    btnMarTodosEstoque.Visible := False;
    btnMarTodosRefugo.Visible := False;
    btnConfirma.Visible := False;
    lblInfoDel.Visible := True;
  End;
  cxGridDadosDBTableView.ViewData.Expand(True);
  TFloatField(FCdsCorrecoes.FieldByName('DOP_QTDITE')).DisplayFormat := fMskDigitos(4);
end;

function TfrmOrdProCorrecoes.fPossuiCorrecoes: Boolean;
var
  blnFilteredBkp: Boolean;
  strFilterBkp: String;
begin
  If Not Assigned(FCdsCorrecoes) Then
    Exit(False);

  blnFilteredBkp := FCdsCorrecoes.Filtered;
  strFilterBkp := FCdsCorrecoes.Filter;
  Try
    FCdsCorrecoes.Filter := 'ITE_EXCLUI = ''S''';
    FCdsCorrecoes.Filtered := True;
    Result := Not FCdsCorrecoes.isEmpty;
  Finally
    FCdsCorrecoes.Filtered := blnFilteredBkp;
    FCdsCorrecoes.Filter := strFilterBkp;
  End;
end;

procedure TfrmOrdProCorrecoes.pDeletaItem;
begin
  If FCdsCorrecoes.FieldByName('DESFAS').AsString = 'ESTRUTURA' Then
  Begin
    pMensagemOk('Este produto é estrutura e não poderá ser deletado!');
    Exit;
  End;

  If FCdsCorrecoes.FieldByName('DOP_QTDITE').AsFloat < 0 Then
  Begin
    pMensagemOk('Este produto contém correção de estrutura negativa e não poderá ser excluído!');
    Exit;
  End;

  If Not (fMensagem('ATENÇÃO', 'Confirma exclusão?',['&Sim','&Não'],1) = 1) Then
    Exit;

  FCdsCorrecoes.Edit;
  FCdsCorrecoes.FieldByName('ITE_EXCLUI').AsString := 'S';
  FCdsCorrecoes.Post;
end;

procedure TfrmOrdProCorrecoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FCdsCorrecoes.Filter := '';
  FCdsCorrecoes.Filtered := False;
end;

procedure TfrmOrdProCorrecoes.FormCreate(Sender: TObject);
begin
  inherited;
  FCdsCorrecoes := TZClient.Create(Self, '');
  FBlnDefinirDestino := False;
  FBlnMontaCds := False;
end;

procedure TfrmOrdProCorrecoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key of
    VK_DELETE :
    begin
      If pnlProdutos.Visible Then
        pDeletaItem;
    end;
    VK_F4:
    begin
      if btnMarTodosEstoque.Visible Then
        btnMarTodosEstoque.Click;
    end;
    VK_F5:
    begin
      if btnMarTodosRefugo.Visible Then
        btnMarTodosRefugo.Click;
    end;

    VK_F10    :
    begin
      Key := 0;
      if btnConfirma.Visible Then btnConfirma.Click;
    end;

    VK_ESCAPE:
      btnSair.Click;
  End;

end;

procedure TfrmOrdProCorrecoes.btnMarTodosEstoqueClick(Sender: TObject);
begin
  inherited;
  pMarcarTodosEstoque;
end;

procedure TfrmOrdProCorrecoes.btnMarTodosRefugoClick(Sender: TObject);
begin
  inherited;
  pMarcarTodosRefugo;
end;

procedure TfrmOrdProCorrecoes.pMarcarTodosRefugo;
begin
  FCdsCorrecoes.DisableControls;
  FCdsCorrecoes.First;
  While Not FCdsCorrecoes.Eof Do
  Begin
    FCdsCorrecoes.Edit;
    FCdsCorrecoes.FieldByName('ITE_DESTIN').AsString := 'R';
    FCdsCorrecoes.Post;
    FCdsCorrecoes.Next;
  End;
  FCdsCorrecoes.EnableControls;
end;

procedure TfrmOrdProCorrecoes.pMarcarTodosEstoque;
begin
  FCdsCorrecoes.DisableControls;
  FCdsCorrecoes.First;
  While Not FCdsCorrecoes.Eof Do
  Begin
    FCdsCorrecoes.Edit;
    FCdsCorrecoes.FieldByName('ITE_DESTIN').AsString := 'E';
    FCdsCorrecoes.Post;
    FCdsCorrecoes.Next;
  End;
  FCdsCorrecoes.EnableControls;
end;

procedure TfrmOrdProCorrecoes.cxGridDadosDBTableViewCustomDrawGroupCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If AViewInfo.Selected Then
    Exit;

  ACanvas.Font.Style := [fsBold];
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridDadosDBTableViewDESFAS.Index]) = 'ESTRUTURA' Then
    ACanvas.Font.Color := clBlack
  Else
    ACanvas.Font.Color := clBlue;
end;

function TfrmOrdProCorrecoes.fGetSQL: String;
begin
  Result := '';
  Result := Result + '  SELECT                                                  ';
  Result := Result + '    ITE_CODITE,                                           ';
  Result := Result + '    ITE_DESITE,                                           ';
  Result := Result + '    ITE_CODFAB,                                           ';
  Result := Result + '    ITE_REFERE,                                           ';
  Result := Result + '    DOP_QTDITE,                                           ';
  Result := Result + '    DOP_NUMLOT,                                           ';
  Result := Result + '    DETPRO.AUTOINCREM AS DOP_AUTINC,                      ';
  Result := Result + '    CAST("" AS CHAR(1)) AS ITE_DESTIN,                    ';
  Result := Result + '    IF(IFNULL(FAS_DESFAS,"") = "", "ESTRUTURA", CONCAT("FASE: ",FAS_DESFAS)) AS DESFAS,  ';
  Result := Result + '    CAST("N" AS CHAR(1)) AS ITE_EXCLUI                    ';
  Result := Result + '  FROM DETPRO                                             ';
  Result := Result + '   INNER JOIN MOVPRO ON DOP_SEQGER = MOVPRO.AUTOINCREM    ';
  Result := Result + '   INNER JOIN CADITE ON ITE_CODITE = DOP_ITESUB           ';
  Result := Result + '    LEFT JOIN FASGER ON DOP_SEQFAS = FASGER.AUTOINCREM    ';
  Result := Result + '  WHERE TRUE                                              ';
  Result := Result + '    AND PRO_CODPRO = ' + QuotedStr(FStrCodPro)             ;
  Result := Result + '    AND PRO_CODEMP = ' + VS_StrCodEmp                      ;
end;

end.


