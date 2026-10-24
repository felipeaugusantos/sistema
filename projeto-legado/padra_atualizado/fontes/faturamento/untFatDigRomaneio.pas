unit untFatDigRomaneio;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Menus, Uni, AppEvnts, Windows, StrUtils, DB,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  untFatGor, untTLock;

type
  TfrmFatDigRomaneio = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlDados: TPanel;
    Label1: TLabel;
    edtNumDoc: TEditFocus;
    tmrAbrirPedido: TTimer;
    btnEntFutCD: TBitBtnLocked;
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnEntFutCDClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    strNumRom: String;
    objLock: TLock;

    Function fRomaneioEncontrado: Boolean;
    function fValidaTransportadora: Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }

  end;

implementation

uses untFuncoes, untFuncoesSimples, untFatExpedicaoRomaneio, untRomGer, untPesqAux, untConstantes,
  untFatEmitirEntFutEmpCD, untLiberacao;

{$R *.dfm}

procedure TfrmFatDigRomaneio.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatDigRomaneio.btnConfirmaDadosClick(Sender: TObject);
  Var
    strChaRom: String;
begin
  inherited;

  If fEmptyStr(strNumRom) Then
    Exit;

  If (Length(strNumRom) > 6) Then
    strNumRom := Copy(strNumRom,2,6);

  strChaRom := 'ROMANEIO_' + strNumRom + VS_strCodEmp;

  If Not objLock.fLock_Unlock(strChaRom, True, False) Then
  Begin
    fMensagem('ATENÇÃO!', 'Este romaneio está sendo utilizado por outra estação: ' + fGetHostLock(strChaRom), ['&Ok']);
    Exit;
  End;

  If Not fTravaDocsRomaneio(strNumRom, objLock) Then
  Begin
    objLock.pDestravarTodos;
    Exit;
  End;

  Try
    edtNumDoc.Text := EmptyStr;

    pCriarFormularios(TfrmFatExpedicaoRomaneio, frmFatExpedicaoRomaneio);
    frmFatExpedicaoRomaneio.Params.VS_strTipExpInterna := VS_strTipExp;
    frmFatExpedicaoRomaneio.Params.blnCarregarQtdExpedida := VS_strTipExp = '5';
    frmFatExpedicaoRomaneio.Caption := frmFatExpedicaoRomaneio.Caption + ' - Documento: ';
    frmFatExpedicaoRomaneio.Caption := frmFatExpedicaoRomaneio.Caption + strNumRom +
                                       ' - RO - ' + VS_strCodEmp;
    frmFatExpedicaoRomaneio.Params.strNumRom := strNumRom;
    frmFatExpedicaoRomaneio.Params.strEspDoc := 'RO';
    frmFatExpedicaoRomaneio.Params.strCodEmp := VS_strCodEmp;
    frmFatExpedicaoRomaneio.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[btnConfirmaDados]');
  End;

  pFreeAndNil(frmFatExpedicaoRomaneio);
  objLock.pDestravarTodos;
end;

procedure TfrmFatDigRomaneio.btnEntFutCDClick(Sender: TObject);
var
  objLiberacao : TLiberacao;
begin
  inherited;

  If Not (fRetQtdPedidosEntFutCD(VS_strCodEmp) > 0) Then
  Begin
    pMensagemOk('Não existem pedidos de entrega futura pelo CD para serem faturados!');
    Exit;
  End;

  objLiberacao := TLiberacao.Create;
  try
    If Not fVerificaAcessoSistema('DIRRCXPEF', strLoginUsuarioLogado) Then
    Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Entrega Futura pelo CD');

      objLiberacao.strDirAce := 'DIRRCXPEF';
      objLiberacao.strMsgSen := 'Ent. Futura CD';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;

      If (Not objLiberacao.fLibera) Then
        Exit;
    End;

    pCriarForm(TfrmFatEmitirEntFutEmpCD, frmFatEmitirEntFutEmpCD);
  finally
    FreeAndNil(objLiberacao);
  end;
end;

procedure TfrmFatDigRomaneio.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(objLock);
end;

procedure TfrmFatDigRomaneio.FormCreate(Sender: TObject);
begin
  inherited;
  strNumRom := EmptyStr;
  objLock   := TLock.Create;
end;

procedure TfrmFatDigRomaneio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (btnEntFutCD.Visible) then
  begin
    if (Shift = [ssCtrl]) then
    Begin
      If Key = Ord('E') Then
        btnEntFutCD.Click
    end;
  end;
end;

procedure TfrmFatDigRomaneio.FormShow(Sender: TObject);
var
  intRetQtdPedidos: Integer;
begin
  inherited;

  btnEntFutCD.Visible := (fCfgSis('PEF_CD') = 'S') And
                         (fCfgSis('ENT_CD') = 'S') And
                         (fCfgSis('EMP_CD') = VS_strCodEmp);

  if btnEntFutCD.Visible then
  begin
    intRetQtdPedidos := fRetQtdPedidosEntFutCD(VS_strCodEmp);
    if intRetQtdPedidos > 0 then
    begin
      btnEntFutCD.Font.Color := clBlue;
      btnEntFutCD.Caption := '[Ctrl+E] Ent.Fut.pelo CD ('+ IntToStr(intRetQtdPedidos) +')';
    end
    else
      btnEntFutCD.Font.Color := clBlack;
  end;

end;

function TfrmFatDigRomaneio.fRomaneioEncontrado: Boolean;
  Var
    qryGen   : TUniQuery;
    qryConTra: TUniQuery;
begin
  Try
    Result := False;
    qryGen := fCriaQuery;

    strNumRom := fTrataNumRom(edtNumDoc);

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      if fCfgSis('RMPDPA', varBoolean) then
      begin
        SQL.Add('SELECT ');
        SQL.Add('  DET_JAFATU AS FGO_JAFATU,');
        SQL.Add('  FGO_CODTRA,');
        SQL.Add('  C.CLI_CODCID ');
        SQL.Add('FROM ');
        SQL.Add('  ROMDETX D');
        SQL.Add('INNER JOIN ROMGERX R ON D.DET_SEQGER = R.AUTOINCREM');
        SQL.Add('INNER JOIN FATDOR FD ON D.DET_AUTINC = FD.AUTOINCREM');
        SQL.Add('INNER JOIN FATGOR G  ON G.AUTOINCREM = FD.FDO_SEQGER');
        SQL.Add(' LEFT JOIN CADCLI C ON C.CLI_CODCLI = G.FGO_CODCLI ');
        SQL.Add('WHERE R.GER_STATUS = "P"');
        SQL.Add('  AND D.DET_EMPROM = :CODEMP');

        If (strNumRom.Length > 6) Then
          SQL.Add('  AND R.GER_CODBAR = :NUMDOC ')
        Else
          SQL.Add('  AND D.DET_NUMROM = :NUMDOC ');

        SQL.Add('ORDER BY G.AUTOINCREM ');
      end
      else
      begin
        SQL.Add('SELECT ');
        SQL.Add('  FGO_JAFATU,');
        SQL.Add('  FGO_CODTRA,');
        SQL.Add('  C.CLI_CODCID ');
        SQL.Add('FROM ');
        SQL.Add('  ROMGERX R INNER JOIN FATGOR G ON R.GER_CODEMP = G.FGO_CODEMP ');
        SQL.Add('                               AND R.GER_NUMDOC = G.FGO_NUMDOC ');
        SQL.Add('                               AND R.GER_ESPDOC = G.FGO_ESPDOC ');
        SQL.Add('                               AND R.GER_CODCLI = G.FGO_CODCLI ');
        SQL.Add('  LEFT JOIN CADCLI C ON C.CLI_CODCLI = G.FGO_CODCLI ');
        SQL.Add('WHERE ');
        SQL.Add('   R.GER_STATUS = "P"     AND ');
        SQL.Add('   R.GER_EMPROM = :CODEMP AND ');

        If (strNumRom.Length > 6) Then
          SQL.Add('   R.GER_CODBAR = :NUMDOC ')
        Else
          SQL.Add('   R.GER_NUMROM = :NUMDOC ');

        SQL.Add('ORDER BY G.AUTOINCREM ');
      end;

      ParamByName('NUMDOC').AsString := strNumRom;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      If Not IsEmpty Then
      Begin
        First;
        While Not EOF Do
        Begin
          If (FieldByName('FGO_JAFATU').AsInteger = 0) Then
          Begin
            Result := True;
            Last;
          End
          Else
            Result := False;

          Next;
        End;

        If Not Result Then
          fMensagem('ATENÇÃO!', 'Romaneio já faturado!', ['&O k'])
        else
        if fValidaTransportadora then
        begin
          First;
          While Not EOF Do
          Begin
            qryConTra := fCriaQuery;
            try
              pPesquisaCadTraCidFrete(qryConTra, qryConTra, FieldByName('FGO_CODTRA').AsString, FieldByName('CLI_CODCID').AsString);
              Result := not fEmptyStr(qryConTra.FieldByName('TRA_NOMTRA').AsString);

              if not Result then
              begin
                fMensagem('ATENÇÃO!', fRetMsgTransportadoraNaoEncontrada(FieldByName('CLI_CODCID').AsString), ['&O k']);
                Break;
              end;
            finally
              FreeAndNil(qryConTra);
            end;

            Next;
          End;
        end;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Romaneio não encontrado!', ['&O k']);
        Result := False;
      End;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmFatDigRomaneio.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumDoc) Then
    Begin

      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Nº do Romaneio!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If Not fRomaneioEncontrado Then
        Begin
          strNumRom := EmptyStr;
          Result    := False;
        End
        Else
        Begin
          btnConfirmaDados.Click;
        End;

      End;

    End;

  End;

  If Not Result Then
    pSetFocus(edtNumDoc);
end;

function TfrmFatDigRomaneio.fValidaTransportadora: Boolean;
begin
  Result := False;

  if not fCfgSis('UTICTE', varBoolean) then
    Exit;

  if not (fCfgSis('FRETRA') = FRETRA_POR_TRANSPORTADORA_CIDADE) then
    Exit;

  Result := True;
end;

end.


