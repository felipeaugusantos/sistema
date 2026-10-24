unit untImpEtiqNotaEntrada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, BitBtnLockedIncrem,
  MemDS, DBAccess, Datasnap.Provider, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient;

type
  TfrmImpEtiqNotaEntrada = class(TfrmPaiOrdena)
    Label4: TLabel;
    edtNumDoc: TEditFocus;
    Label5: TLabel;
    edtEspDoc: TEditFocus;
    Label6: TLabel;
    edtSerie: TEditFocus;
    Label1: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    lblCodEmp: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    Label2: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label3: TLabel;
    mskDtaFin: TMaskEditFocus;
    btnItens: TBitBtnLocked;
    chkImpNot: TCheckBox;
    chkImpGrp: TCheckBox;
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtNumDocEnter(Sender: TObject);
    procedure btnItensClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    qryMovAux: TUniQuery;

    procedure pLimpaCampos;
    procedure pMostraItens(strAutInc: String);
    procedure pAbreConsulta;
    function fSQLNotas: String;
    function fObterCaptionTelaItens(strSeqGer: string): string;
    function fSQLCaptionNota: String;
  public
    { Public declarations }
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmImpEtiqNotaEntrada: TfrmImpEtiqNotaEntrada;

implementation

{$R *.dfm}

uses
      untConsultas, untConstantes, untFuncoesSimples, untImpEtiqNotaEntradaItens,
  untTypesSistema, untModulo;

function TfrmImpEtiqNotaEntrada.fSQLNotas: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   G.AUTOINCREM,';
  strSQL := strSQL + '   GER_DTAENT,  ';
  strSQL := strSQL + '   GER_NUMDOC,  ';
  strSQL := strSQL + '   GER_ESPDOC,  ';
  strSQL := strSQL + '   GER_SERIE_,  ';
  strSQL := strSQL + '   GER_CODEMP,  ';
  strSQL := strSQL + '   GER_CODFOR,  ';
  strSQL := strSQL + '   FOR_NOMFOR,  ';
  strSQL := strSQL + '   GER_VLRCON   ';
  strSQL := strSQL + ' FROM           ';
  strSQL := strSQL + ' MOVGER G ';
  strSQL := strSQL + ' INNER JOIN CADFOR ON FOR_CODFOR = GER_CODFOR ';
  strSQL := strSQL + ' WHERE               ';
  strSQL := strSQL + '   GER_TIP_FC = "F"  ';
  strSQL := strSQL + ' AND ((LEFT(G.GER_CLAFIS,1) = 1) OR (LEFT(G.GER_CLAFIS,1) = 2) OR (LEFT(G.GER_CLAFIS,1) = 3)) ';

  If Not fEmptyStr(edtNumDoc.Text) Then
    strSQL := strSQL + '  AND GER_NUMDOC = :NUMDOC ';

  If Not fEmptyStr(edtEspDoc.Text) Then
    strSQL := strSQL + '  AND GER_ESPDOC = :ESPDOC ';

  If Not fEmptyStr(edtSerie.Text) Then
    strSQL := strSQL + '  AND IFNULL(GER_SERIE_, "") = :SERIE_ ';

  If Not fEmptyStr(edtCodEmp.Text) Then
    strSQL := strSQL + '  AND GER_CODEMP = :CODEMP ';

  If Not fEmptyStr(edtCodFor.Text) Then
    strSQL := strSQL + '  AND GER_CODFOR = :CODFOR ';

  If Not fEmptyDate(mskDtaIni.Text) Then
    strSQL := strSQL + '  AND GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  Result := strSQL;
End;

function TfrmImpEtiqNotaEntrada.fSQLCaptionNota: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   G.AUTOINCREM,';
  strSQL := strSQL + '   GER_NUMDOC AS NUMDOC,  ';
  strSQL := strSQL + '   GER_ESPDOC AS ESPDOC,  ';
  strSQL := strSQL + '   GER_SERIE_ AS SERIE,  ';
  strSQL := strSQL + '   GER_CODEMP AS CODEMP ';
  strSQL := strSQL + ' FROM           ';
  strSQL := strSQL + ' MOVGER G ';
  strSQL := strSQL + ' WHERE               ';
  strSQL := strSQL + '  G.AUTOINCREM = :AUTOINCREM ';

  Result := strSQL;
End;

function TfrmImpEtiqNotaEntrada.fObterCaptionTelaItens(strSeqGer: string): string;
var
  qryDadosNota: TUniQuery;
begin
  qryDadosNota := TUniQuery.Create(Self);
  try
    qryDadosNota.Connection := frmModulo.GetCurrentConnection;
    qryDadosNota.SQL.Add(fSQLCaptionNota);
    qryDadosNota.ParamByName('AUTOINCREM').AsString := strSeqGer;
    qryDadosNota.Open;
    Result := 'Itens da Nota ' + qryDadosNota.FieldByName('NUMDOC').AsString + '-' + qryDadosNota.FieldByName('ESPDOC').AsString + '-' +
      qryDadosNota.FieldByName('CODEMP').AsString + '-' + qryDadosNota.FieldByName('SERIE').AsString;
    qryDadosNota.Close;
  finally
    qryDadosNota.DisposeOf;
  end;
end;

procedure TfrmImpEtiqNotaEntrada.btnItensClick(Sender: TObject);
begin
  inherited;

  If Not cdsConsulta.IsEmpty Then
    pMostraItens(cdsConsulta.FieldByName('AUTOINCREM').AsString);
end;

procedure TfrmImpEtiqNotaEntrada.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmImpEtiqNotaEntrada.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmImpEtiqNotaEntrada.edtNumDocEnter(Sender: TObject);
begin
  inherited;

  cdsConsulta.Close;
  pLimpaCampos;
end;

function TfrmImpEtiqNotaEntrada.fGetSql(blnLike: Boolean): String;
  Var
    strSQL: String;
Begin
  strSQL := fSQLNotas + fFiltraSQL(blnlike);
  Result := strSQL;
End;

procedure TfrmImpEtiqNotaEntrada.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumDoc);
end;

procedure TfrmImpEtiqNotaEntrada.FormCreate(Sender: TObject);
begin
  inherited;
  blnQuoteLista := False;

  {********************************************************}
  { Verifica o tamanho do campo Número do Documento.     . }
  { Necessário porque tem banco com tamanho 6 e outros 12. }
  {*****************************************************MA*}
  qryMovAux := fCriarQuery('SELECT GER_NUMDOC FROM MOVGER WHERE FALSE', Self);
  edtNumDoc.MaxLength := qryMovAux.FieldByName('GER_NUMDOC').Size;
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;
  FreeAndNil(qryMovAux);
end;

procedure TfrmImpEtiqNotaEntrada.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  Case Key Of

    VK_RETURN: If ((ActiveControl) = dbgConsulta) Then
                 btnItens.Click
               Else
                 inherited;

    VK_ESCAPE: If pnlPesquisa.Visible Then
                 inherited
               Else If ((ActiveControl) = edtNumDoc) Then
                 Close
               Else
               Begin
                 pLimpaCampos;
                 edtNumDoc.Focused;
               End

    Else       inherited;

  End;

end;

procedure TfrmImpEtiqNotaEntrada.FormResize(Sender: TObject);
begin
  inherited;
  btnSair.Left := pnlBotoes.ClientWidth - btnSair.Width - 3;
end;

procedure TfrmImpEtiqNotaEntrada.FormShow(Sender: TObject);
begin
  inherited;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftDateTime;

  pLimpaCampos;

end;

function TfrmImpEtiqNotaEntrada.fSetParametros: Boolean;
Begin
  With qryConsulta Do
  Begin

    If Not fEmptyStr(edtNumDoc.Text) Then
      ParamByName('NUMDOC').AsString := edtNumDoc.Text;

    If Not fEmptyStr(edtEspDoc.Text) Then
      ParamByName('ESPDOC').AsString := edtEspDoc.Text;

    If Not fEmptyStr(edtSerie.Text) Then
      ParamByName('SERIE_').AsString := edtSerie.Text;

    If Not fEmptyStr(edtCodEmp.Text) Then
      ParamByName('CODEMP').AsString := edtCodEmp.Text;

    If Not fEmptyStr(edtCodFor.Text) Then
      ParamByName('CODFOR').AsString := edtCodFor.Text;

    If Not fEmptyDate(mskDtaIni.Text) Then
    Begin
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
    End;

  End;

  Result := True;
End;

function TfrmImpEtiqNotaEntrada.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumDoc) Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        mskDtaIni.Enabled := True;
        mskDtaFin.Enabled := True;
      End Else
      Begin
        mskDtaIni.Enabled := False;
        mskDtaIni.Clear;
        mskDtaFin.Enabled := False;
        mskDtaFin.Clear;
      End;
    End

    Else If (Sender = edtCodFor) Then
    Begin
      If (Not fEmptyStr(edtCodFor.Text)) Then
      Begin
        edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);

        If fEmptyStr(edtNomFor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse fornecedor não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End

      Else
        edtNomFor.Clear;
    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtNomEmp.Clear;
      End
      Else
      Begin
        edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End

      End;

      If Result And (Not mskDtaIni.Enabled) And blnBuscaPorChave Then
        pAbreConsulta;

    End

    Else If (Sender = mskDtaIni) Then
    Begin

      If mskDtaIni.Enabled Then
      Begin

        If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&O k']);
          Result := False;
        End

        Else mskDtaIni.Text := DateToStr(StrToDate(mskDtaIni.Text));

      End;

    End

    Else If (Sender = mskDtaFin) Then
    Begin

      If mskDtaFin.Enabled Then
      Begin

        If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          mskDtaFin.Text := DateToStr(StrToDate(mskDtaFin.Text));

          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
            Result := False;
          End
          Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
            Result := False;
          End

          Else If blnBuscaPorChave Then
             pAbreConsulta;

        End;

      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmImpEtiqNotaEntrada.pAbreConsulta;
Begin
  If fEmptyDate(mskDtaIni.Text) And fEmptyStr(edtNumDoc.Text) Then
  Begin
    pMensagemOk('Informe o Número do Documento ou um período para seleção!');
    Exit;
  End;

  If fVerificaCampos Then
  Begin
    If Assigned(stlListSelecao) Then
      stlListSelecao.Clear;
    fAbreConsulta;
  End;
End;

procedure TfrmImpEtiqNotaEntrada.pLimpaCampos;
Begin
  edtNumDoc.Clear;
  edtEspDoc.Clear;
  edtSerie.Clear;
  edtCodFor.Clear;
  edtNomFor.Clear;
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;
  mskDtaIni.Clear;
  mskDtaFin.Clear;
  mskDtaIni.Enabled := True;
  mskDtaFin.Enabled := True;
End;

procedure TfrmImpEtiqNotaEntrada.pMostraItens(strAutInc: String);
var i: integer;
Begin
  If stlListSelecao.Count > 1 Then
  Begin
    pCriarFormularios(TfrmImpEtiqNotaEntradaItens, frmImpEtiqNotaEntradaItens);
    Try
      For i := 0 To stlListSelecao.Count -1 do
      Begin

        If Assigned(frmImpEtiqNotaEntradaItens) Then
        Begin
          frmImpEtiqNotaEntradaItens.strSeqGer := stlListSelecao[i];
          frmImpEtiqNotaEntradaItens.Caption   := fObterCaptionTelaItens(stlListSelecao[i]);
          frmImpEtiqNotaEntradaItens.blnImpNot := chkImpNot.Checked;
          frmImpEtiqNotaEntradaItens.blnImpGrp := chkImpGrp.Checked;
          frmImpEtiqNotaEntradaItens.cdsConsulta.IndexFieldNames := 'AUTOINCREM';
          frmImpEtiqNotaEntradaItens.ShowModal;
        End;
      End;
    Finally
      FreeAndNil(frmImpEtiqNotaEntradaItens);
    End;
  End
  Else
  Begin
    pCriarFormularios(TfrmImpEtiqNotaEntradaItens, frmImpEtiqNotaEntradaItens);
    Try
      If Assigned(frmImpEtiqNotaEntradaItens) Then
      With frmImpEtiqNotaEntradaItens, cdsConsulta Do
      Begin
        strSeqGer := strAutInc;
        Caption   := fObterCaptionTelaItens(strAutInc);
        blnImpNot := chkImpNot.Checked;
        blnImpGrp := chkImpGrp.Checked;
        cdsConsulta.IndexFieldNames := 'AUTOINCREM';

        ShowModal;
      End;
    Finally
      FreeAndNil(frmImpEtiqNotaEntradaItens);
    End;
  End;
End;

end.
