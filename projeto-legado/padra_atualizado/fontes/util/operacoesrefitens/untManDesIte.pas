unit untManDesIte;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, EditFocus, MemoFocus, Uni, frxClass, frxExportCSVTestabilidade;

type
  TfrmManDesIte = class(TfrmPai)
    pnlCodIte: TPanel;
    pnlDados: TPanel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    lblProduto: TLabel;
    mmoAplIte: TMemoFocus;
    lbl2: TLabel;
    Label1: TLabel;
    edtDesCom: TEditFocus;
    Label2: TLabel;
    edtDesSim: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure pGravaLogAlteracaoCPR(strCodIte, strNomCam: String; varValorNovo, varValorAntigo: Variant);
  private
    strDesAnt : String;
    strDesSim: String;
    strAplica: String;
    procedure pCarregaDados(strCodIte : String);
    function fGravaDados : Boolean;
    procedure pLimpaDados;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;override;
  end;

var
  frmManDesIte: TfrmManDesIte;

implementation

uses untFuncoesSimples, untConsultas, untAltDes, Data.DB, untTypesSistema;

{$R *.dfm}

procedure TfrmManDesIte.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pnlCodIte.Enabled   := True;
  pnlDados.Enabled    := False;
  btnConfirma.Enabled := False;
  btnCancela.Enabled  := False;

  pLimpaDados;
  
end;

procedure TfrmManDesIte.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  if fGravaDados then 
    pMensagemOk('Alteração Realizada com Sucesso!');
end;

procedure TfrmManDesIte.edtCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrSel, True, nil, 'Consulta de Itens', '1') Then
  Begin
    if fValidaCampos(edtCodIte, False) then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmManDesIte.fGravaDados: Boolean;
  Var
    qryDados : TUniQuery;
begin
  Result := False;
  Try
    qryDados := fCriaQuery(Self);

    Try
      With qryDados, Sql do
      Begin
        Text := 'UPDATE CADITE SET         ' +
                '     ITE_DESITE = :DESITE,' +
                '     ITE_DESSIM = :DESSIM,' +
                '     ITE_APLICA = :APLICA ' +
                'WHERE ITE_CODITE = :CODITE';

        ParamByName('CODITE').AsString := edtCodIte.Text;
        ParamByName('DESITE').AsString := edtDesCom.Text;
        ParamByName('DESSIM').AsString := edtDesSim.Text;
        ParamByName('APLICA').AsString := mmoAplIte.Texto;

        ExecSQL;

        If (RowsAffected > 0) and (strDesAnt <> edtDesCom.Text) Then
          TAltDes.pSalvaLog(edtCodIte.Text, strLoginUsuarioLogado, strDesAnt, '', '', strDesSim, strAplica);

        If (RowsAffected > 0) and (strDesAnt <> edtDesCom.Text) Then
          pGravaLogAlteracaoCPR(edtCodIte.Text, 'Descrição do Item', edtDesCom.Text, strDesAnt);

        If (RowsAffected > 0) and (strDesSim <> edtDesSim.Text) Then
          pGravaLogAlteracaoCPR(edtCodIte.Text, 'Descrição Simplificada', edtDesSim.Text, strDesSim);

        If (RowsAffected > 0) and (strAplica <> mmoAplIte.Text) Then
          pGravaLogAlteracaoCPR(edtCodIte.Text, 'Aplicação', mmoAplIte.Text, strAplica);


      End;
      Result := True;

      pLimpaDados;
    Except
      Result := False;
    end;

  Finally
    FreeAndNil(qryDados);
    pnlDados.Enabled    := not Result;
    btnConfirma.Enabled := not Result;
    btnCancela.Enabled  := not Result;
    pnlCodIte.Enabled   := Result;

    pSetFocus(edtCodIte);
  end;

end;

procedure TfrmManDesIte.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodIte);
  pSetaCodIte(edtCodIte);
end;

function TfrmManDesIte.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;
  if inherited fValidaCampos(Sender, blnBuscaPorChave) then
  Begin
    if Sender = edtCodIte then
    Begin
      edtDesIte.Text := fRetNomProduto(edtCodIte.Text);

      if fEmptyStr(edtDesIte.Text) then
      Begin
        pMensagemOK('Produto informado não Existe!');
        Result := False;
      End
      Else
        pCarregaDados(edtCodIte.Text);


    End;

  End;

  if not Result then
    pSetFocus(Sender);

end;

procedure TfrmManDesIte.pCarregaDados(strCodIte: String);
  Var
    qryDados : TUniQuery;
begin
  Try
    qryDados := fCriaQuery(Self);
    With qryDados, Sql Do
    Begin
      Text := 'SELECT SQL_NO_CACHE       ' +
              '       ITE_CODITE,        ' +
              '       ITE_DESITE,        ' +
              '       ITE_DESSIM,        ' +
              '       ITE_APLICA         ' +
              'FROM CADITE               ' +
              'WHERE ITE_CODITE = :CODITE';

      ParamByName('CODITE').AsString := strCodIte;

      Open;

      pnlDados.Enabled    := not IsEmpty;
      btnConfirma.Enabled := not IsEmpty;
      btnCancela.Enabled  := not IsEmpty;
      pnlCodIte.Enabled   := IsEmpty;

      if not IsEmpty then
      Begin
        strDesAnt      := FieldByName('ITE_DESITE').AsString;
        edtDesCom.Text := FieldByName('ITE_DESITE').AsString;
        edtDesSim.Text := FieldByName('ITE_DESSIM').AsString;
        mmoAplIte.Text := fReplaceStr( FieldByName('ITE_APLICA').AsString, STRING_QUEBRA, #13#10);
        strAplica := mmoAplIte.Text;
        strDesSim := edtDesSim.Text;
      End;

    End;

  Finally
    FreeAndNil(qryDados);
  end;
end;

procedure TfrmManDesIte.pGravaLogAlteracaoCPR(strCodIte, strNomCam: String; varValorNovo, varValorAntigo: Variant);
Var
  qryLogCpr: TUniQuery;
Begin
  qryLogCpr := fCriaQuery;
  Try
    qryLogCpr.SQL.Text := 'SELECT * FROM LOGCPR WHERE FALSE';
    qryLogCpr.Open;
    qryLogCpr.Append;
    qryLogCpr.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LOGCPR', VS_strCodEmp);
    qryLogCpr.FieldByName('LOG_CODITE').AsString := strCodIte;
    qryLogCpr.FieldByName('LOG_CODOPE').AsString := strLoginUsuarioLogado;
    qryLogCpr.FieldByName('LOG_DTAALT').AsDateTime := VS_Date;
    qryLogCpr.FieldByName('LOG_HORALT').AsDateTime := fTime();
    qryLogCpr.FieldByName('LOG_NOMCAM').AsString := fUpper(strNomCam);
    qryLogCpr.FieldByName('LOG_EMPLOG').AsString := VS_strCodEmp;
    qryLogCpr.FieldByName('LOG_EMPFIS').AsString := fRetEmpresaFisica;

    If varValorAntigo <> null Then
      qryLogCpr.FieldByName('LOG_VALANT').Value := varValorAntigo;
    If varValorNovo <> null Then
      qryLogCpr.FieldByName('LOG_VALPOS').Value := varValorNovo;

    qryLogCpr.Post;
  Finally
    FreeAndNil(qryLogCpr);
  End;
End;

procedure TfrmManDesIte.pLimpaDados;
begin
  edtCodIte.Clear;
  edtDesCom.Clear;
  edtDesSim.Clear;
  mmoAplIte.Clear;
  edtCodIte.Clear;
  edtDesIte.Clear;

  pSetFocus(edtCodIte);

end;

end.
