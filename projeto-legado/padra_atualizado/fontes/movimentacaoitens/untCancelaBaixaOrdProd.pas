unit untCancelaBaixaOrdProd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, untOrdPro, Uni, StrUtils, cxProgressBar;

type
  TfrmCancelaBaixaOrdProd = class(TfrmPai)
    pnlOrdPro: TPanel;
    Label3: TLabel;
    edtOrdPro: TEditFocus;
    pnlDadCli: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    edtCodIte: TEditFocus;
    edtObs001: TEditFocus;
    edtObs002: TEditFocus;
    edtConfer: TEditFocus;
    edtDesIte: TEditFocus;
    btnConfirma: TBitBtnLocked;
    Label6: TLabel;
    edtProduzido: TEditFocus;
    procedure edtOrdProKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    objOrdPro: TOrdPro;
    FBlnCancelandoRefugo: Boolean;
    blnMonFas: Boolean;
    procedure pCarregaDados;
    procedure pRestauraCustoITEGER(strSeqMov: String);
    function fExisteRegistroBaixadoAposOPSelecionada(strCodIte: String; strSeqGer: String): Boolean;
    function fCancelaProgresso(cxProgress : TcxProgressBar) : Boolean;
  public
    class function fCancelaBaixa(AStrCodPro: String): Boolean;
  published
    property blnCancelandoRefugo: Boolean read FblnCancelandoRefugo write FBlnCancelandoRefugo;
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean; override;
  end;

implementation

{$R *.dfm}

uses untTypesSistema, untFuncoesSimples, untConsultas, untCadIte, untGravando,
  untExibeArvoreOrdProd, untIFatReservaSaldo, untTFatReservaSaldo, untModulo;

procedure TfrmCancelaBaixaOrdProd.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (Not blnCancelandoRefugo) Then
  Begin
    If Not fPergunta('Deseja cancelar a baixa da ordem de produção?') Then
      Exit;
  End;

  if objOrdPro.fExisteNivelSuperiorComBaixa(objOrdPro.strAutInc) then
  begin
    fMensagem('ATENÇÃO', 'Não é possível cancelar uma ordem de produção que tenha ordem de produção de nivel superior baixada', ['&OK']);
    Exit;
  end;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Cancelando a Baixa, Aguarde....';
    frmGravando.pgbStatus.Visible   := False;
    frmGravando.fExecutarAcao       := fCancelaProgresso;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;

end;

class function TfrmCancelaBaixaOrdProd.fCancelaBaixa(AStrCodPro: String): Boolean;
var
  frmCancelaOp: TFrmCancelaBaixaOrdProd;
begin
  Result := True;
  pCriarFormularios(TfrmCancelaBaixaOrdProd, frmCancelaOp);
  Try
    frmCancelaOp.edtOrdPro.Text := AStrCodPro;
    frmCancelaOp.blnCancelandoRefugo := True;
    frmCancelaOp.btnConfirma.Click;
  Finally
    FreeAndNil(frmCancelaOp);
  End;
end;

function TfrmCancelaBaixaOrdProd.fCancelaProgresso(cxProgress: TcxProgressBar): Boolean;
  Var
    qryDados  : TUniQuery;
    strAutIncOrdSav: String;
    blnInTransaction: Boolean;
begin
  Result := True;
  blnInTransaction := frmModulo.Database.InTransaction;
  Try
    Screen.Cursor := crHourGlass;

    qryDados := fCriaQuery(Self);

    strAutIncOrdSav:= '';

    If Not blnInTransaction Then
      fStartTransaction;
    Try

      // Volta o estoque e apaga movdet
      With qryDados, SQL Do
      Begin
        Close;
        Clear;
        Add(' SELECT *                   ');
        Add(' FROM MOVDET                ');
        Add(' WHERE DET_ORDPRO = :ORDPRO ');
        Add('   AND DET_CODEMP = :CODEMP ');
        Add('   AND DET_ESPDOC = "OP"    ');

        ParamByName('ORDPRO').AsString := edtOrdPro.Text;
        ParamByName('CODEMP').AsString := VS_strCodEmp;

        Open;
        First;
        While Not Eof Do
        Begin
          If Not fAtualizaEstoqueCadIte(FieldByName('DET_CODITE').AsString,
                                        IfThen( StrToInt(LeftStr(FieldByName('DET_CLAFIS').AsString,1))>=5, 'E', 'S'),
                                        FieldByName('DET_QTDITE').AsFloat,
                                        0.0,
                                        FieldByName('DET_NUMLOT').AsString) Then
          Begin
            Result := False;
            Exit;
          End;

          ReprocessarItem(FieldByName('DET_CODITE').AsString, '', False);

          fVerificaIntegridade(Self.Name, 'MOVDET', qryDados);

          Next;
        End;

        First;
        While Not Eof Do
          qryDados.Delete;

        //Apaga movger.
        Close;
        Clear;
        Add(' SELECT *                   ');
        Add(' FROM MOVGER                ');
        Add(' WHERE GER_ORDPRO = :ORDPRO ');
        Add('   AND GER_CODEMP = :CODEMP ');
        Add('   AND GER_ESPDOC = "OP"    ');

        ParamByName('ORDPRO').AsString := edtOrdPro.Text;
        ParamByName('CODEMP').AsString := VS_strCodEmp;

        Open;

        While Not Eof Do
        Begin
          fVerificaIntegridade(Self.Name, 'MOVGER', qryDados);
          Next;
        End;

        First;
        While Not Eof Do
          qryDados.Delete;

        Close;
        SQL.Clear;
        SQL.Add('UPDATE MOVPRO              ');
        SQL.Add('SET PRO_DTABAI = NULL,     ');
        SQL.Add('    PRO_HORBAI = NULL,     ');
        SQL.Add('    PRO_QTDPRO = 0,        ');
        SQL.Add('    PRO_CONFER = NULL      ');
        SQL.Add('WHERE PRO_CODPRO = :CODPRO ');
        SQL.Add('  AND PRO_CODEMP = :CODEMP ');

        ParamByName('CODPRO').AsString := edtOrdPro.Text;
        ParamByName('CODEMP').AsString := VS_strCodEmp;

        ExecSQL;

        Close;

        If (blnMonFas) Then
        Begin
          Close;
          SQL.Clear;
          SQL.Add('DELETE FROM RFGORD WHERE ORD_SEQORD = (SELECT AUTOINCREM FROM MOVPRO WHERE PRO_CODPRO = :CODPRO AND PRO_CODEMP = :CODEMP) ');
          ParamByName('CODPRO').AsString := edtOrdPro.Text;
          ParamByName('CODEMP').AsString := VS_strCodEmp;
          ExecSQL;
        End;
      End;

      If (fCfgSis('ATPCPM') = 'S') Then
      Begin
        strAutIncOrdSav:= fRetornaAutIncMovPro('', edtOrdPro.Text, VS_strCodEmp);
        If fExisteOrdSav(strAutIncOrdSav) Then
          pRestauraCustoITEGER(strAutIncOrdSav);
      End;

    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, 'TfrmCancelaBaixaOrdProd.btnConfirmaClick');
      End;
    End;

  Finally
    Screen.Cursor := crDefault;

    If Not Result Then
    Begin
      If Not blnInTransaction Then
        fRollBack
    End
    Else
    Begin
      If Not blnInTransaction Then
        fCommit;

      edtOrdPro.Clear;
      edtConfer.Clear;
      edtCodIte.Clear;
      edtDesIte.Clear;
      edtObs001.Clear;
      edtObs002.Clear;
      edtProduzido.Clear;

      pSetFocus(edtOrdPro);

      If Not blnCancelandoRefugo Then
        pMensagemOK('Cancelamento Efetuado com Sucesso!');

    End;

    FreeAndNil(qryDados);
  End;


end;

function TfrmCancelaBaixaOrdProd.fExisteRegistroBaixadoAposOPSelecionada(strCodIte: String; strSeqGer: String): Boolean;
Var
  qryCons  : TUniQuery;
Begin
  qryCons := fCriaQuery(Self);
  Try
    qryCons.Close;
    qryCons.SQL.Clear;
    qryCons.SQL.Add(' SELECT * FROM MOVSAV ');
    qryCons.SQL.Add('   WHERE ITE_CODITE = :CODITE AND ');
    qryCons.SQL.Add('         ITE_CODEMP = :CODEMP     ');
    qryCons.SQL.Add('   ORDER BY ITE_DTABAI, ITE_HORBAI DESC ');
    qryCons.ParamByName('CODITE').AsString:= strCodIte;
    qryCons.ParamByName('CODEMP').AsString:= VS_strCodEmp;
    qryCons.Open;

    qryCons.Locate('ITE_SEQGER', strSeqGer, []);
    If qryCons.FindPrior Then
      Result:= True
    Else
      Result:= False;

  Finally
    FreeAndNil(qryCons);
  End;
End;

procedure TfrmCancelaBaixaOrdProd.pRestauraCustoITEGER(strSeqMov: String);
CONST
    SQL_UPDATE = ' UPDATE ITEGER SET         '+
                 '     ITE_PRECOM = :PRECOM, '+
                 '     ITE_PREMED = :PREMED, '+
                 '     ITE_IMPULT = :IMPULT  '+
                 ' WHERE ITE_CODITE = :CODITE';

    SQL_DELETE = 'DELETE FROM MOVSAV WHERE ITE_SEQGER = :SEQGER';

  Var
    qryCons  : TUniQuery;
    qryExec  : TUniQuery;
begin
  qryCons := fCriaQuery(Self);
  qryExec := fCriaQuery(Self);
  Try
    qryCons.Close;
    qryCons.SQL.Clear;
    qryCons.SQL.Add('SELECT * FROM MOVSAV WHERE ITE_SEQGER = :SEQGER');
    qryCons.ParamByName('SEQGER').AsString:= strSeqMov;
    qryCons.Open;

    If Not fExisteRegistroBaixadoAposOPSelecionada(qryCons.FieldByName('ITE_CODITE').AsString, strSeqMov) Then
    Begin
      qryExec.Close;
      qryExec.SQL.Clear;
      qryExec.SQL.Add(SQL_UPDATE);
      qryExec.ParamByName('PRECOM').AsFloat := qryCons.FieldByName('ITE_PRECOM').AsFloat;
      qryExec.ParamByName('PREMED').AsFloat := qryCons.FieldByName('ITE_PREMED').AsFloat;
      qryExec.ParamByName('IMPULT').AsFloat := qryCons.FieldByName('ITE_IMPULT').AsFloat;
      qryExec.ParamByName('CODITE').AsString:= qryCons.FieldByName('ITE_CODITE').AsString;
      qryExec.ExecSQL;
    End;

    qryExec.Close;
    qryExec.SQL.Clear;
    qryExec.SQL.Add(SQL_DELETE);
    qryExec.ParamByName('SEQGER').AsString:= strSeqMov;
    qryExec.ExecSQL;


  Finally
    FreeAndNil(qryCons);
    FreeAndNil(qryExec);
  End;

End;

procedure TfrmCancelaBaixaOrdProd.edtOrdProKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strSQL: String;
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'WHERE PRO_DTABAI IS NOT NULL ';
    strSQL := strSQL + '  AND PRO_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

    if fPesqOrdemProd(conSimples,
                      Self,
                      edtOrdPro,
                      nil,
                      objOrdPro.qryOrdPro,
                      Key,
                      arrSel,
                      strSQL) then
    Begin
      objOrdPro.pAtuDados;
      edtOrdPro.Text := objOrdPro.strCodPro;

      If fValidaCampos(edtOrdPro, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCancelaBaixaOrdProd.FormCreate(Sender: TObject);
begin
  inherited;
  objOrdPro := TOrdPro.Create(Self, False);
  blnMonFas := fCfgSis('MONFAS', varBoolean);
end;

procedure TfrmCancelaBaixaOrdProd.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objOrdPro);
  inherited;
end;

function TfrmCancelaBaixaOrdProd.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If (Sender = edtOrdPro) Then
    Begin
      If fEmptyStr(edtOrdPro.Text) Then
      Begin
        fMensagem('','Inform o numero da ordem de produção!', ['&OK']);
        Result := False;
      End
      Else
      Begin

        If blnBuscaPorChave And objOrdPro.fCarregaOrdPro(edtOrdPro.Text, True) Then
        Begin
          If fEmptyStr(objOrdPro.strDtaBai) Then
          Begin
            Result := False;
            pMensagemOK('A ordem de produção informada não está baixada!');
          End
          Else If (blnMonFas) And (objOrdPro.blnNotaRefugoVinculada) Then
          Begin
            Result := False;
            pMensagemOk('A ordem de produção informada possui nota de refugo vinculada!'+#13#10+
                        'Utilize o cancelamento de documentos para cancelar a nota de refugo e automaticamente cancelar a baixa da ordem de produção!');
          End
          Else
            pCarregaDados;
        End

        Else
        Begin
          fMensagem('','Ordem de produção não encontrada!',['&OK']);
          Result := False;
        End;

      End;
    End;

  End;

end;

procedure TfrmCancelaBaixaOrdProd.pCarregaDados;
begin
  edtConfer.Text   := objOrdPro.strConfer;
  edtCodIte.Text   := objOrdPro.strCodIte;
  edtDesIte.Text   := objOrdPro.strDesIte;
  edtObs001.Text   := objOrdPro.strObs001;
  edtObs002.Text   := objOrdPro.strObs002;
  edtProduzido.Text:= objOrdPro.strQtdPro;
end;

end.
