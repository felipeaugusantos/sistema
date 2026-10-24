unit untCalNivGirEstFornecMarkup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, MaskEditFocus, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, cxCurrencyEdit, BitBtnLockedIncrem, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, Spin,
  cxDataControllerConditionalFormattingRulesManagerDialog, frxClass,
  frxExportCSVTestabilidade, untTypesSistema, uni;

type
  TfrmCalNivGirEstFornecMarkup = class(TfrmPaiEdit)
    pnlFiltros: TPanel;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    Label5: TLabel;
    Label6: TLabel;
    lblEmpresa: TLabel;
    Label1: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    grbTabPreco: TGroupBox;
    Label9: TLabel;
    edtNomTab: TEditFocus;
    edtTabPre: TEditFocus;
    cxgGruposView: TcxGridDBTableView;
    cxgGruposLevel1: TcxGridLevel;
    cxgGrupos: TcxGrid;
    cxgGruposViewColumn1: TcxGridDBColumn;
    cxgGruposViewColumn2: TcxGridDBColumn;
    cxgGruposViewColumn3: TcxGridDBColumn;
    cxgGruposViewColumn4: TcxGridDBColumn;
    cxgGruposViewColumn5: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    chkArrMai: TCheckBox;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtTabPreKeyPress(Sender: TObject; var Key: Char);
    procedure edtTabPreExit(Sender: TObject);
    procedure cxgGruposViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    arrTabPre: TConsultasArray;

    procedure pAlimentaTabelaPreco;
    function fValidaFornecedorDaTabela: Boolean;

    { Private declarations }
  public
    { Public declarations }
    qryTabelaPreco: TUniQuery;
    blnConfirma: Boolean;
  end;

var
  frmCalNivGirEstFornecMarkup: TfrmCalNivGirEstFornecMarkup;

implementation
uses
    untFuncoesSimples, untFuncoesConsulta, untConsultas;

{$R *.dfm}


procedure TfrmCalNivGirEstFornecMarkup.pAlimentaTabelaPreco;
var i: integer;
begin
  If Assigned(qryTabelaPreco) then
  Begin
    qryTabelaPreco.SQL.Clear;
    qryTabelaPreco.SQL.Add('SELECT TABDET.*,  ');
    For i := 1 To 7 do
    Begin
      qryTabelaPreco.SQL.Add('  C'+i.toString+'.DET_ICMSAI CUS_ICMSAI'+i.toString+',');
      qryTabelaPreco.SQL.Add('  C'+i.toString+'.DET_DESOPE CUS_DESOPE'+i.toString+',');
      qryTabelaPreco.SQL.Add('  C'+i.toString+'.DET_OUTVAL CUS_OUTVAL'+i.toString+', ');
      qryTabelaPreco.SQL.Add('  C'+i.toString+'.DET_PREVEN DET_PREVEN'+i.toString+', ');
    end;
    qryTabelaPreco.SQL.Add(' IFNULL(ITEFOR.ITE_CNVCUS, 1) AS ITE_CNVCUS ');
    qryTabelaPreco.SQL.Add(' FROM TABDET');


    qryTabelaPreco.SQL.Add(' INNER JOIN ITEFOR ON ITEFOR.ITE_CODITE = TABDET.ITE_CODITE AND ITEFOR.ITE_CODTAB = TABDET.ITE_CODTAB');

    qryTabelaPreco.SQL.Add('  LEFT JOIN DETCUS C1 ON C1.DET_SEQDET = TABDET.AUTOINCREM AND C1.DET_TABELA = 1');
    qryTabelaPreco.SQL.Add('  LEFT JOIN DETCUS C2 ON C2.DET_SEQDET = TABDET.AUTOINCREM AND C2.DET_TABELA = 2');
    qryTabelaPreco.SQL.Add('  LEFT JOIN DETCUS C3 ON C3.DET_SEQDET = TABDET.AUTOINCREM AND C3.DET_TABELA = 3');
    qryTabelaPreco.SQL.Add('  LEFT JOIN DETCUS C4 ON C4.DET_SEQDET = TABDET.AUTOINCREM AND C4.DET_TABELA = 4');
    qryTabelaPreco.SQL.Add('  LEFT JOIN DETCUS C5 ON C5.DET_SEQDET = TABDET.AUTOINCREM AND C5.DET_TABELA = 5');
    qryTabelaPreco.SQL.Add('  LEFT JOIN DETCUS C6 ON C6.DET_SEQDET = TABDET.AUTOINCREM AND C6.DET_TABELA = 6');
    qryTabelaPreco.SQL.Add('  LEFT JOIN DETCUS C7 ON C7.DET_SEQDET = TABDET.AUTOINCREM AND C7.DET_TABELA = 7');

    qryTabelaPreco.SQL.Add(' WHERE TABDET.ITE_CODTAB = :CODTAB AND TABDET.ITE_CODEMP = "'+VS_StrCodEmp+'"');
    qryTabelaPreco.ParamByName('CODTAB').AsString := edtTabPre.Text;
    qryTabelaPreco.Open;
  End;
end;

function TfrmCalNivGirEstFornecMarkup.fValidaFornecedorDaTabela: Boolean;
begin
  Result := True;
  If Assigned(qryTabelaPreco) then
    Result := qryTabelaPreco.FieldByName('ITE_CODFOR').AsString = edtFornecedor.Text;
End;


procedure TfrmCalNivGirEstFornecMarkup.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtNomTab.Text) Then
  Begin
    pMensagemOk('É preciso informar a tabela de preços!');
    pSetFocus(edtNomTab);
    Exit;
  End;


  pAlimentaTabelaPreco;
  If not fValidaFornecedorDaTabela Then
  Begin
    pMensagemOk('A Tabela informada não pertence ao fornecedor '+ edtFornecedor.Text + '!');
    pSetFocus(edtNomTab);
    Exit;
  End;

  With cxgGruposView.DataController.DataSet Do
  Begin
    If State = dsEdit Then
      Post;

    First;
    While Not Eof Do
    Begin
      Edit;
        If FieldByName('MKPNVA').IsNull Then
          FieldByName('MKPNVA').AsFloat := 0;

        If FieldByName('MKPNVB').IsNull Then
          FieldByName('MKPNVB').AsFloat := 0;

        If FieldByName('MKPNVC').IsNull Then
          FieldByName('MKPNVC').AsFloat := 0;
      Post;

      If (FieldByName('MKPNVA').AsFloat <= 0) Or
         (FieldByName('MKPNVB').AsFloat <= 0) Or
         (FieldByName('MKPNVC').AsFloat <= 0) Then
      Begin
        pMensagemOk('As margens devem ser maiores que zero!');
        Exit;
      End;

      Next;
    End;
  End;

  If fPergunta('Confirma os dados informados?') Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmCalNivGirEstFornecMarkup.cxgGruposViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If key = VK_RETURN Then
  Begin
    If cxgGruposViewColumn5.Focused Then
    Begin
      cxgGruposView.NavigatorButtons.Next.Click;
      cxgGruposViewColumn3.Focused := True;
    End
    Else
      cxgGruposView.Controller.FocusNextCell(True);
  End;

end;

procedure TfrmCalNivGirEstFornecMarkup.edtTabPreExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtTabPre,edtNomTab,arrTabPre,fRetNomeTabelaPreco,nil,'do Fornecedor');
end;

procedure TfrmCalNivGirEstFornecMarkup.edtTabPreKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqTabelaPreco(Self, edtTabPre, edtNomTab, nil, Key, arrTabPre, True, edtFornecedor.Text) Then
  Begin
    If fValidaCampos(edtTabPre, True) Then
      pProximoControle(edtTabPre);
  End;

end;

procedure TfrmCalNivGirEstFornecMarkup.FormCreate(Sender: TObject);
begin
  inherited;

  blnConfirma := False;
end;

procedure TfrmCalNivGirEstFornecMarkup.FormShow(Sender: TObject);
begin
  inherited;

  cxgGruposView.NavigatorButtons.First.Click;
end;

end.
