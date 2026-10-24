unit untCadAjuDet;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Uni, Data.DB, EditFocus,
  DBGridCitel, untTypesSistema;

type
  TfrmCadAjuDet = class(TfrmPaiCad)
    lblCodAju: TLabel;
    lblDesAju: TLabel;
    lblBasIcm: TLabel;
    lblAlqIcm: TLabel;
    lblValIcm: TLabel;
    lblOutros: TLabel;
    edtCodAju: TDBEditFocus;
    edtBasIcm: TDBEditFocus;
    edtAlqIcm: TDBEditFocus;
    edtValIcm: TDBEditFocus;
    edtOutros: TDBEditFocus;
    dbgrdAjuDet: TDBGridCitel;
    Label4: TLabel;
    edtCodIte: TDBEditFocus;
    dtsAjdIcm: TDataSource;
    edtDesAju: TEditFocus;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgrdAjuDetKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure edtBasIcmExit(Sender: TObject);
    procedure edtAlqIcmExit(Sender: TObject);
    procedure edtCodAjuKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAjuExit(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dtsAjdIcmDataChange(Sender: TObject; Field: TField);
  private
    arrAju: TConsultasArray;
    FQryFisItens: TUniQuery;
    FAutoIncrem: String;
    FCodEmp: String;
    procedure pSetQry(const Value: TUniQuery);
    procedure pFormataCampos;
    procedure phabilitaGrid;
    function fCalculaValorIcms(fltBase, fltAlq: Double): String;
    function fValidaProdutoInformado: Boolean;
  protected
    procedure pInicializaIndices; override;
  public
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

    property QryFisItens: TUniQuery write pSetQry;
    property strAutoIncrem: String read FAutoIncrem write FAutoIncrem;
    property strCodEmp: String read FCodEmp write FCodEmp;
  end;

implementation

uses untSelecionaItens, untFuncoesSimples, untFuncoesConsulta, untConsultas;

{$R *.dfm}

procedure TfrmCadAjuDet.btnAlterarClick(Sender: TObject);
begin
  inherited;
  phabilitaGrid;
  pSetFocus(edtCodAju);
end;

procedure TfrmCadAjuDet.btnCancelaClick(Sender: TObject);
begin
  inherited;
  phabilitaGrid;
end;

procedure TfrmCadAjuDet.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAjuDet.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  edtDesAju.Text := '';
end;

procedure TfrmCadAjuDet.btnGravarClick(Sender: TObject);
begin
  If (qryTabela.State = dsInsert) Then
  Begin
    qryTabela.FieldByName('AJD_SEQGER').AsString := FAutoIncrem;
    qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FISAJD', FCodEmp);
  End;

  phabilitaGrid;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAjuDet.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadAjuDet.btnIncluirClick(Sender: TObject);
begin
  inherited;

  phabilitaGrid;
  pSetFocus(edtCodAju);
  pnlInfo.Caption := '';
end;

procedure TfrmCadAjuDet.btnPesquisaClick(Sender: TObject);
  Var
    strSQL, strSQLWhere: String;
    qryConsulta: TUniQuery;
    arrSel: TConsultasArray;
    arrTitCol: Array of String;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;
begin

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  AJD_CD_AJU, '; pAddNomeColuna('Cód. Ajuste');
  strSQL := strSQL + '  AJD_DESAJU, '; pAddNomeColuna('Descrição');
  strSQL := strSQL + '  AJD_CODITE, '; pAddNomeColuna('Cód. Item');
  strSQL := strSQL + '  AJD_BASICM, '; pAddNomeColuna('Base ICMS');
  strSQL := strSQL + '  AJD_ALQICM, '; pAddNomeColuna('Alq. ICMS');
  strSQL := strSQL + '  AJD_VALICM, '; pAddNomeColuna('Valor ICMS');
  strSQL := strSQL + '  AJD_OUTROS, '; pAddNomeColuna('Outros');
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FISAJD ';

  strSQLWhere := strSQLWhere + 'WHERE AJD_SEQGER = ' + QuotedStr(FAutoIncrem);

  qryConsulta := fCriaQuery(Nil);
  Try
    If fConsulta([strSQL, strSQLWhere],
                 arrTitCol,
                 ['AJD_CD_AJU'],
                 'AUTOINCREM',
                 'FISAJD',
                 Self.Name,
                 'Cadastro de Ajuste detalhado',
                 qryConsulta,
                 nil,
                 True,
                 arrSel,
                 'AUTOINCREM',
                 nil) Then
    Begin
      qryTabela.Locate('AUTOINCREM', VarArrayOf([qryConsulta.FieldByName('AUTOINCREM').AsString]), []);

      edtCodAju.Text := qryConsulta.FieldByName('AJD_CD_AJU').AsString;
      edtDesAju.Text := qryConsulta.FieldByName('AJD_DESAJU').AsString;
      edtCodIte.Text := qryConsulta.FieldByName('AJD_CODITE').AsString;
      edtBasIcm.Text := FloatToStrF(qryConsulta.FieldByName('AJD_BASICM').AsFloat, ffFixed, 015, 002);
      edtAlqIcm.Text := FloatToStrF(qryConsulta.FieldByName('AJD_ALQICM').AsFloat, ffFixed, 015, 002);
      edtValIcm.Text := FloatToStrF(qryConsulta.FieldByName('AJD_VALICM').AsFloat, ffNumber, 015, 002);
      edtOutros.Text := FloatToStrF(qryConsulta.FieldByName('AJD_OUTROS').AsFloat, ffNumber, 015, 002);

      btnAlterarClick(Sender);
      pSetFocus(edtCodAju);
    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmCadAjuDet.dbgrdAjuDetKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If Key = #13 Then
    btnAlterarClick(Sender);
end;

procedure TfrmCadAjuDet.dtsAjdIcmDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  edtDesAju.Text := qryTabela.FieldByName('AJD_DESAJU').AsString;
end;

procedure TfrmCadAjuDet.edtAlqIcmExit(Sender: TObject);
begin
  inherited;
  edtValIcm.Field.AsString := fCalculaValorIcms(fStrToFloat(edtBasIcm.Text), fStrToFloat(edtAlqIcm.Text));
end;

procedure TfrmCadAjuDet.edtBasIcmExit(Sender: TObject);
begin
  inherited;
  edtValIcm.Field.AsString := fCalculaValorIcms(fStrToFloat(edtBasIcm.Text), fStrToFloat(edtAlqIcm.Text));
end;

procedure TfrmCadAjuDet.edtCodAjuExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAju, edtDesAju, arrAju, fRetDesAjuIcm, Nil, 'do ajuste');
  qryTabela.FieldByName('AJD_DESAJU').AsString := edtDesAju.Text;
end;

procedure TfrmCadAjuDet.edtCodAjuKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqAju(Self, edtCodAju, edtDesAju, nil, Key, arrAju) Then
  Begin
    If fValidaCampos(edtCodAju, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadAjuDet.edtCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    objItem: TfrmSelecionaItens;
begin
  inherited;

  If Key = '/' Then
  Begin
    objItem := TfrmSelecionaItens.Create(Nil);
    Try
      Key := #0;

      objItem.qryAux := FQryFisItens;
      objItem.ShowModal;

      edtCodIte.Text := objItem.strCodItem;

      If fEmptyStr(edtCodIte.Text) Then
        pSetFocus(edtCodIte)
      Else
        pSetFocus(edtBasIcm);
    Finally
      objItem.Free;
    End;
  End;
end;

function TfrmCadAjuDet.fCalculaValorIcms(fltBase, fltAlq: Double): String;
begin
  Result := FloatToStrF((fltBase * fltAlq) / 100, ffNumber, 12, 2);
end;

procedure TfrmCadAjuDet.FormCreate(Sender: TObject);
begin
  inherited;

  If fTabelaExiste('FISAJD', True) Then
  Begin
    pVerificaProCod;
    pValidaProCod('FISAJD');
  End;

  strNomeTabela := 'FISAJD';
  strNomeCampo  := 'AUTOINCREM';

  blnUsaAutInc := False;
end;

procedure TfrmCadAjuDet.FormShow(Sender: TObject);
begin
  qryTabela := fCriaQuery(Self);
  dtsAjdIcm.DataSet := qryTabela;

  inherited;

  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Text := 'SELECT * FROM FISAJD WHERE AJD_SEQGER = :SEQGER ';
  qryTabela.ParamByName('SEQGER').AsString := FAutoIncrem;
  qryTabela.Open;

  pFormataCampos;

  pSetFocus(btnIncluir);

  pSetaCodIte( edtCodIte );

end;

function TfrmCadAjuDet.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodIte) And (fValidaProdutoInformado) Then
    Begin
      fMensagem('Atenção', 'O produto informado não foi encontrado no documento', ['OK']);
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadAjuDet.fValidaProdutoInformado: Boolean;
begin
  Result := False;

  If Not FQryFisItens.Locate('CODITE', edtCodIte.Text, []) Then
    Result := True;
end;

procedure TfrmCadAjuDet.pFormataCampos;
begin
  TFloatField(qryTabela.FieldByName('AJD_BASICM')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('AJD_BASICM')).DisplayFormat := '#,##0.00';

  TFloatField(qryTabela.FieldByName('AJD_ALQICM')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('AJD_ALQICM')).DisplayFormat := '#,##0.00';

  TFloatField(qryTabela.FieldByName('AJD_VALICM')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('AJD_VALICM')).DisplayFormat := '#,##0.00';

  TFloatField(qryTabela.FieldByName('AJD_OUTROS')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('AJD_OUTROS')).DisplayFormat := '#,##0.00';
end;

procedure TfrmCadAjuDet.phabilitaGrid;
begin
  dbgrdAjuDet.Enabled := Not (dbgrdAjuDet.Enabled);
end;

procedure TfrmCadAjuDet.pInicializaIndices;
begin
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;

  stlCampos.Add('AJD_SEQGER');
  stlCampos.Add('AJD_CD_AJU');
  stlCampos.Add('AJD_DESAJU');
  stlCampos.Add('AJD_CODITE');
  stlCampos.Add('AJD_BASICM');
  stlCampos.Add('AJD_ALQICM');
  stlCampos.Add('AJD_VALICM');
  stlCampos.Add('AJD_OUTROS');
  stlCampos.Add('AUTOINCREM');
end;

procedure TfrmCadAjuDet.pSetQry(const Value: TUniQuery);
begin
  FQryFisItens := Value;
end;

end.
