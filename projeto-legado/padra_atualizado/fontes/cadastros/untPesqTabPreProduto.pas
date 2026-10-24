unit untPesqTabPreProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, EditFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, DB, cxDBData, cxCurrencyEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxClasses,
  cxGridCustomView, cxGrid, untTypesSistema,
  untFuncoesSimples, untZClient, frxClass, frxExportCSVTestabilidade,
  cxGridDBTableView, cxGridCitel,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmPesqTabPreProduto = class(TfrmPaiEdit)
    pnl1: TPanel;
    lbl1: TLabel;
    edtDesIte: TEditFocus;
    edtCodIte: TEditFocus;
    rdgStatus: TRadioGroup;
    cxgDados: TcxGridCitel;
    cxbDadosView: TcxGridDBTableViewCitel;
    cxcDadosViewColumn1: TcxGridDBColumn;
    cxcDadosViewColumn2: TcxGridDBColumn;
    cxcDadosViewColumn3: TcxGridDBColumn;
    cxcDadosViewColumn4: TcxGridDBColumn;
    cxcDadosViewColumn5: TcxGridDBColumn;
    cxlGrid1Level1: TcxGridLevel;
    cxcDadosViewColumn6: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    cxbDadosViewColumn1: TcxGridDBColumn;
    cxbDadosViewColumn2: TcxGridDBColumn;
    cxbDadosViewColumn3: TcxGridDBColumn;
    cxbDadosViewColumn4: TcxGridDBColumn;
    cxbDadosViewColumn6: TcxGridDBColumn;
    cxcDadosViewColumn7: TcxGridDBColumn;
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure cxbDadosViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdgStatusClick(Sender: TObject);
  private
    { Private declarations }

    arrProduto: TConsultasArray;
    cdsConsulta: TZClient;

    Function fSQLDados: String;
    procedure pAbreConsulta;

  public
    { Public declarations }

    Class Function fSelecionaTabela(strCodIte : String = ''): String;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmPesqTabPreProduto: TfrmPesqTabPreProduto;

implementation
uses
     untConsultas, untFuncoesConsulta;

{$R *.dfm}

procedure TfrmPesqTabPreProduto.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  Close;
end;

procedure TfrmPesqTabPreProduto.cxbDadosViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: btnConfirma.Click;
  End; 

end;

procedure TfrmPesqTabPreProduto.edtCodIteExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodIte, edtDesIte, arrProduto, Nil, fRetNomProduto, 'do Produto');
end;

procedure TfrmPesqTabPreProduto.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqItem(conIteSimples,
               Self,
               edtCodIte,
               edtDesIte,
               Nil,
               Key,
               arrProduto,
               True,
               Nil,
               'Consulta de Itens',
               '1',
               '',
               0,
               false,
               false,
               0) And
     fValidaCampos(edtCodIte, True) Then
   Begin
     Self.SelectNext(ActiveControl, True, True);
   End;

end;

procedure TfrmPesqTabPreProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If cdsConsulta.IsEmpty Then
    Begin
      pMensagemOk('Selecione uma Tabela de Preço!');
      Action := caNone;
    End

  End;
end;

procedure TfrmPesqTabPreProduto.FormCreate(Sender: TObject);
begin
  inherited;

  cdsConsulta := TZClient.Create(Self, fSQLDados);

  cxbDadosView.DataController.DataSource := cdsConsulta.dtsSource;

end;

procedure TfrmPesqTabPreProduto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If TWinControl(rdgStatus.Controls[rdgStatus.ItemIndex]).Focused Then
                 pAbreConsulta;
                 
    VK_F10   : btnConfirma.Click;
  End;

end;

procedure TfrmPesqTabPreProduto.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodIte);
end;

function TfrmPesqTabPreProduto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;

Begin
  Result := True;

  If (Sender = edtCodIte) Then
  Begin

    If fEmptyStr(edtCodIte.Text) Then
    Begin
      pMensagemOk('Informe o Código do Produto!');
      Result := False;
    End

    Else If blnBuscaPorChave Then
    Begin
      pAbreConsulta;
      blnMudarFoco := False;
    End;  

  End

  Else If (Sender = rdgStatus) Then
  Begin
  End;

  If Not Result Then
    pSetFocus(Sender);
End;

procedure TfrmPesqTabPreProduto.pAbreConsulta;
Begin
  cdsConsulta.qryQuery.SQL.Text := fSQLDados;
  cdsConsulta.qryQuery.ParamByName('CODITE').AsString := edtCodIte.Text;
  cdsConsulta.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

  If fVerificaCampos And cdsConsulta.fAbreClient(True, 'TfrmComparaTabPre.pAbreConsulta') Then
  Begin
    cdsConsulta.pAlinhaCampoCentro('CODTAB');
    cdsConsulta.pAlinhaCampoCentro('CODFOR');
    cdsConsulta.pAlinhaCampoCentro('ATICMP');
    cdsConsulta.pAlinhaCampoCentro('DTACAD');

    TFloatField(cdsConsulta.FieldByName('PRECOM')).DisplayFormat := '#,##0.00';
    TFloatField(cdsConsulta.FieldByName('PRECUS')).DisplayFormat := '#,##0.00';

    cxbDadosView.NavigatorButtons.First.Click;
    pSetFocus(cxgDados);
  End;
End;

procedure TfrmPesqTabPreProduto.rdgStatusClick(Sender: TObject);
begin
  inherited;

  pAbreConsulta;
end;

Function TfrmPesqTabPreProduto.fSQLDados: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   TAB_CODTAB AS CODTAB, ';
  strSQL := strSQL + '   TAB_NOMTAB AS NOMTAB, ';
  strSQL := strSQL + '   TAB_CODFOR AS CODFOR, ';
  strSQL := strSQL + '   FOR_NOMFOR AS NOMFOR, ';
  strSQL := strSQL + '   TAB_ATICMP AS ATICMP, ';
  strSQL := strSQL + '   TAB_DTACAD AS DTACAD, ';
  strSQL := strSQL + '   IFNULL(D.ITE_PRECUS, F.ITE_PRECUS) AS PRECUS, ';
  strSQL := strSQL + '   IFNULL(D.ITE_PRECOM, F.ITE_PRECOM) AS PRECOM, ';
  strSQL := strSQL + '   ITE_CNVCUS AS EMBALA, ';
  strSQL := strSQL + '   UNI_SIGUNI AS UNICOM, ';
  strSQL := strSQL + '   ITE_DENSID AS DENSID, ';
  strSQL := strSQL + '   F.ITE_CODITF AS CODFAB, ';
  strSQL := strSQL + '   (IFNULL(D.ITE_PRECOM, F.ITE_PRECOM) / IFNULL(ITE_CNVCUS, 1)) AS PREKIL ';
  strSQL := strSQL + ' FROM ITEFOR F           ';

  strSQL := strSQL + ' INNER JOIN TABPRE   ON TAB_CODTAB   = F.ITE_CODTAB ';
  strSQL := strSQL + '  LEFT JOIN TABDET D ON D.ITE_SEQGER = F.AUTOINCREM AND D.ITE_CODEMP = :CODEMP';
  strSQL := strSQL + ' INNER JOIN CADFOR   ON FOR_CODFOR   = F.ITE_CODFOR ';
  strSQL := strSQL + ' INNER JOIN CADITE   ON CADITE.ITE_CODITE = F.ITE_CODITE ';
  strSQL := strSQL + ' INNER JOIN CADUNI   ON UNI_CODUNI = F.ITE_UNICOM ';

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   F.ITE_CODITE = :CODITE ';

  Case rdgStatus.ItemIndex Of
    0: strSQL := strSQL + ' AND TAB_ATICMP = "S"  ';
    1: strSQL := strSQL + ' AND TAB_ATICMP = "N"  ';
  End;

  Result := strSQL;
End;

Class Function TfrmPesqTabPreProduto.fSelecionaTabela(strCodIte : String): String;
Begin
  pCriarFormularios(TfrmPesqTabPreProduto, frmPesqTabPreProduto);

  If Not fEmptyStr(strCodIte) Then
  Begin
    frmPesqTabPreProduto.edtCodIte.Text := strCodIte;
    frmPesqTabPreProduto.fValidaCampos(frmPesqTabPreProduto.edtCodIte, True);
  End;

  If (frmPesqTabPreProduto.ShowModal = mrOk) And
     (Not frmPesqTabPreProduto.cdsConsulta.IsEmpty) Then
    Result := frmPesqTabPreProduto.cdsConsulta.FieldByName('CODTAB').AsString
  Else
    Result := '';

  FreeAndNil(frmPesqTabPreProduto);
End;


end.
