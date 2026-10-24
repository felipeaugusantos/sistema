unit untComparaTabPre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxGridBandedTableView, cxGridDBBandedTableView, cxCurrencyEdit, EditFocus,
  untFuncoesSimples, untZClient, untTypesSistema,
  cxProgressBar, cxDataControllerConditionalFormattingRulesManagerDialog,
  frxClass, frxExportCSVTestabilidade;


type
  TfrmComparaTabPre = class(TfrmPaiEdit)
    pnl1: TPanel;
    cxlGrid1Level1: TcxGridLevel;
    cxgDados: TcxGrid;
    cxbDadosView: TcxGridDBBandedTableView;
    cxcDadosViewColumn1: TcxGridDBBandedColumn;
    cxcDadosViewColumn2: TcxGridDBBandedColumn;
    cxcDadosViewColumn3: TcxGridDBBandedColumn;
    cxcDadosViewColumn4: TcxGridDBBandedColumn;
    cxcDadosViewColumn5: TcxGridDBBandedColumn;
    cxcDadosViewColumn6: TcxGridDBBandedColumn;
    cxcDadosViewColumn7: TcxGridDBBandedColumn;
    cxcDadosViewColumn8: TcxGridDBBandedColumn;
    cxcDadosViewColumn9: TcxGridDBBandedColumn;
    cxcDadosViewColumn10: TcxGridDBBandedColumn;
    cxcDadosViewColumn13: TcxGridDBBandedColumn;
    lbl1: TLabel;
    edtDesIte: TEditFocus;
    edtCodIte: TEditFocus;
    rdgStatus: TRadioGroup;
    cxs1: TcxStyleRepository;
    cxs2: TcxStyle;
    cxcDadosViewColumn15: TcxGridDBBandedColumn;
    cxbDadosViewColumn1: TcxGridDBBandedColumn;
    cxbDadosViewColumn2: TcxGridDBBandedColumn;
    cxbDadosViewColumn3: TcxGridDBBandedColumn;
    cxbDadosVALFRE: TcxGridDBBandedColumn;
    cxbDadosViewColumn5: TcxGridDBBandedColumn;
    cxbDadosDESADB: TcxGridDBBandedColumn;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure rdgStatusClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    cdsConsulta: TZClient;

    arrProduto: TConsultasArray;

    Function fSQLDados: String;

    procedure pAbreConsulta;

    Procedure pFormataCampos;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmComparaTabPre: TfrmComparaTabPre;

Procedure pTabelasRelaciondas(strCodIte: String);

implementation

{$R *.dfm}

Uses
  untParCalculaPrecoCusto, Math,
   untConsultas, untFuncoesConsulta,untGravando;
  
procedure TfrmComparaTabPre.edtCodIteExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodIte, edtDesIte, arrProduto, Nil, fRetNomProduto, 'do Produto');
end;

procedure TfrmComparaTabPre.edtCodIteKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmComparaTabPre.rdgStatusClick(Sender: TObject);
begin
  inherited;

  pAbreConsulta;
end;

procedure TfrmComparaTabPre.FormCreate(Sender: TObject);
begin
  inherited;

  cdsConsulta := TZClient.Create(Self, fSQLDados);

  cxbDadosView.DataController.DataSource := cdsConsulta.dtsSource;
end;

procedure TfrmComparaTabPre.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_RETURN:  If TWinControl(rdgStatus.Controls[rdgStatus.ItemIndex]).Focused Then
                  pAbreConsulta;
  End;

  inherited;
end;

procedure TfrmComparaTabPre.FormShow(Sender: TObject);
begin
  inherited;

  cxbDadosVALFRE.Caption := fCfgSis('DESVFR') + ' (+)';
  cxbDadosDESADB.Caption := fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + ')';

  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);

  If Not fEmptyStr(edtDesIte.Text) Then
    pAbreConsulta;

  pSetFocus(edtCodIte);
end;

procedure TfrmComparaTabPre.pAbreConsulta;
Begin
  cdsConsulta.qryQuery.SQL.Text := fSQLDados;
  cdsConsulta.qryQuery.ParamByName('CODITE').AsString := edtCodIte.Text;
  cdsConsulta.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

  If fVerificaCampos And cdsConsulta.fAbreClient(True, 'TfrmComparaTabPre.pAbreConsulta') Then
  Begin
    cdsConsulta.pAlinhaCampoCentro('TAB_CODTAB');
    cdsConsulta.pAlinhaCampoCentro('TAB_CODFOR');
    cdsConsulta.pAlinhaCampoCentro('TAB_ATICMP');
    cdsConsulta.pAlinhaCampoCentro('ITE_DTAULT');

    pFormataCampos;

    If Not cdsConsulta.IsEmpty Then
    Begin
      pSetFocus(cxgDados);
      cxbDadosView.NavigatorButtons.First.Click;
    End;

  End;
End;


Procedure TfrmComparaTabPre.pFormataCampos;
  Var
    intDecUni: Integer;
Begin
  intDecUni := fCfgSis('DECUNI', varInteger);

  TFloatField(cdsConsulta.FieldByName('ITE_PRECOM')).DisplayFormat := fMskDigitos(intDecUni);
  TFloatField(cdsConsulta.FieldByName('ITE_DESF01')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_DESF02')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_DESF03')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_DESF04')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_DESF05')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_DESF06')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_COMLIQ')).DisplayFormat := fMskDigitos(intDecUni);
  TFloatField(cdsConsulta.FieldByName('ITE_ICMENT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_SUBFED')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_IPIENT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_FREENT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_VALFRE')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_ACRFIN')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_SUBSTI')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_DESADB')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_PRECUS')).DisplayFormat := fMskDigitos(intDecUni);
  TFloatField(cdsConsulta.FieldByName('ITE_OUTVAL')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_ICMSAI')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_IMPFED')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_DESOPE')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_TCIFCU')).DisplayFormat := '#,##0.000000';
  TFloatField(cdsConsulta.FieldByName('ITE_TSCUST')).DisplayFormat := '#,##0.000000';
  TFloatField(cdsConsulta.FieldByName('ITE_DEPICO')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_DEICMS')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_FATREG')).DisplayFormat := '#,##0.00';

  TFloatField(cdsConsulta.FieldByName('ITE_MARBRU')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsConsulta.FieldByName('ITE_COMTBL')).DisplayFormat := '#,##0.00';
  TFloatField(cdsConsulta.FieldByName('ITE_PREVEN')).DisplayFormat := fMskDigitos(intDecUni);
  TFloatField(cdsConsulta.FieldByName('ITE_PREREV')).DisplayFormat := fMskDigitos(intDecUni);
End;


Function TfrmComparaTabPre.fSQLDados: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   TAB_CODTAB, ';
  strSQL := strSQL + '   TAB_NOMTAB, ';
  strSQL := strSQL + '   TAB_CODFOR, ';
  strSQL := strSQL + '   FOR_NOMFOR, ';
  strSQL := strSQL + '   TAB_ATICMP, ';

  strSQL := strSQL + '   F.ITE_CODFAB, ';
  strSQL := strSQL + '   F.ITE_MLTCOM, ';

  strSQL := strSQL + '  (D.ITE_PRECOM * ';
  strSQL := strSQL + '   ( 1 - (D.ITE_DESF01 / 100) ) * ';
  strSQL := strSQL + '   ( 1 - (D.ITE_DESF02 / 100) ) * ';
  strSQL := strSQL + '   ( 1 - (D.ITE_DESF03 / 100) ) * ';
  strSQL := strSQL + '   ( 1 - (D.ITE_DESF04 / 100) ) * ';
  strSQL := strSQL + '   ( 1 - (D.ITE_DESF05 / 100) ) * ';
  strSQL := strSQL + '   ( 1 - (D.ITE_DESF06 / 100) )) / IF(IFNULL(F.ITE_CNVCUS, 0) <> 0, F.ITE_CNVCUS, 1) AS ITE_COMLIQ, ';

  strSQL := strSQL + '   IF(IFNULL(F.ITE_CNVCUS, 0) <> 0, F.ITE_CNVCUS, 1) AS ITE_CNVCUS, ';

  strSQL := strSQL + '   D.ITE_PRECUS / IF(IFNULL(F.ITE_CNVCUS, 0) <> 0, F.ITE_CNVCUS, 1) AS ITE_PRECUS, ';
  strSQL := strSQL + '   D.ITE_VALFRE / IF(IFNULL(F.ITE_CNVCUS, 0) <> 0, F.ITE_CNVCUS, 1) AS ITE_VALFRE, ';

  strSQL := strSQL + '   G.ITE_DTAULT, ';

  strSQL := strSQL + '   D.* ';

  strSQL := strSQL + ' FROM ITEFOR F ';

  strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = F.ITE_CODITE AND ';
  strSQL := strSQL + '                        G.ITE_CODEMP = :CODEMP           ';

  strSQL := strSQL + ' INNER JOIN TABDET D ON D.ITE_CODTAB = F.ITE_CODTAB AND ';
  strSQL := strSQL + '                        D.ITE_CODITE = F.ITE_CODITE AND ';
  strSQL := strSQL + '                        D.ITE_CODEMP = G.ITE_CODEMP     ';

  strSQL := strSQL + ' INNER JOIN TABPRE   ON TAB_CODTAB   = F.ITE_CODTAB ';

  strSQL := strSQL + ' INNER JOIN CADFOR   ON FOR_CODFOR   = F.ITE_CODFOR ';

  strSQL := strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = F.ITE_CODITE ';

  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   F.ITE_CODITE = :CODITE ';

  Case rdgStatus.ItemIndex Of
    0: strSQL := strSQL + ' AND TAB_ATICMP = "S"  ';
    1: strSQL := strSQL + ' AND TAB_ATICMP = "N"  ';
  End;

  Result := strSQL;
End;

function TfrmComparaTabPre.fValidaCampos(Sender: TWinControl;
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
     pAbreConsulta;

  End

  Else If (Sender = rdgStatus) Then
  Begin
  End;

  If Not Result Then
   pSetFocus(Sender);
End;

Procedure pTabelasRelaciondas(strCodIte: String);
Begin
  pCriarFormularios(TfrmComparaTabPre, frmComparaTabPre);
  frmComparaTabPre.edtCodIte.Text := strCodIte;
  frmComparaTabPre.ShowModal;
  FreeAndNil(frmComparaTabPre);
End;

end.
