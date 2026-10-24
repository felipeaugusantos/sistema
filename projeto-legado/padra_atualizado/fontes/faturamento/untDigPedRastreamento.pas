unit untDigPedRastreamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, EditFocus, Vcl.Grids, Vcl.DBGrids, DBGridCitel, Datasnap.DBClient, Uni, UniClientDataSet;

type
  TfrmDigPedRastreamento = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    Label6: TLabel;
    pnlPedidos: TPanel;
    dbgItensPedCmp: TDBGridCitel;
    edtNumPedido: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    Label2: TLabel;
    edtNotaFiscal: TEditFocus;
    Label4: TLabel;
    edtNumRegistro: TEditFocus;
    cdsRastroPed: TUniClientDataSet;
    dtsRastroPed: TDataSource;
    cdsRastroPedRTM_CODEMP: TStringField;
    cdsRastroPedRTM_NUMDOC: TStringField;
    cdsRastroPedRTM_NUMFAT: TStringField;
    cdsRastroPedRTM_NUMREG: TStringField;
    cdsRastroPedAUTOINCREM: TStringField;
    cdsRastroPedRTM_TIPFAT: TStringField;
    cdsRastroPedRTM_EMPFAT: TStringField;
    edtTipFat: TEditFocus;
    Label1: TLabel;
    edtEmpFat: TEditFocus;
    Label3: TLabel;
    Label5: TLabel;
    btnEnviarEmail: TBitBtnLocked;
    btnEnviarWpp: TBitBtnLocked;
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnEnviarEmailClick(Sender: TObject);
    procedure btnEnviarWppClick(Sender: TObject);
  private
    procedure pCarregarRegistroRastreamento;
    procedure pAtualizaRegistroPedido(strRegCon : String);
  public
    strNumDoc,
    strSeqFgo,
    strEspOri,
    strNumOri,
    strEmpOri,
    strCodCli,
    strEspDoc,
    strCodEmp : String;

  end;

implementation

uses
  untFuncoes,
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmDigPedRastreamento.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmDigPedRastreamento.btnConfirmaDadosClick(Sender: TObject);
  Var
    qryGen: TUniQuery;
    strRegCon: String;
begin
  inherited;

  strRegCon := '';

  Try
    qryGen := fCriaQuery;

    qryGen.SQL.Add('DELETE FROM FATRTM ');
    qryGen.SQL.Add('  WHERE ');
    qryGen.SQL.Add(' RTM_NUMDOC = :NUMDOC AND ');
    qryGen.SQL.Add(' RTM_CODEMP = :CODEMP ');

    qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.ExecSQL;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[btnConfirmaDadosClick]');
    End;
  End;
  FreeAndNil(qryGen);

  If cdsRastroPed.RecordCount > 0 Then
  Begin

    Try
      qryGen := fCriaQuery;

      cdsRastroPed.First;
      While Not cdsRastroPed.Eof Do
      Begin

        strRegCon := cdsRastroPedRTM_NUMREG.AsString + ' / ' + strRegCon;

        qryGen.SQL.Clear;
        qryGen.SQL.Add('INSERT INTO ');
        qryGen.SQL.Add(' FATRTM ');
        qryGen.SQL.Add('(AUTOINCREM, ');
        qryGen.SQL.Add(' RTM_CODEMP, ');
        qryGen.SQL.Add(' RTM_NUMDOC, ');
        qryGen.SQL.Add(' RTM_NUMFAT, ');
        qryGen.SQL.Add(' RTM_TIPFAT, ');
        qryGen.SQL.Add(' RTM_EMPFAT, ');
        qryGen.SQL.Add(' RTM_NUMREG) ');
        qryGen.SQL.Add(' VALUES ');
        qryGen.SQL.Add('(:AUTINC, ');
        qryGen.SQL.Add(' :CODEMP, ');
        qryGen.SQL.Add(' :NUMDOC, ');
        qryGen.SQL.Add(' :NUMFAT, ');
        qryGen.SQL.Add(' :TIPFAT, ');
        qryGen.SQL.Add(' :EMPFAT, ');
        qryGen.SQL.Add(' :NUMREG) ');

        qryGen.ParamByName('AUTINC').AsString := fRetAutoIncrem('FATRTM', VS_strCodEmp);
        qryGen.ParamByName('CODEMP').AsString := cdsRastroPedRTM_CODEMP.AsString;
        qryGen.ParamByName('NUMDOC').AsString := cdsRastroPedRTM_NUMDOC.AsString;
        qryGen.ParamByName('NUMFAT').AsString := cdsRastroPedRTM_NUMFAT.AsString;
        qryGen.ParamByName('TIPFAT').AsString := cdsRastroPedRTM_TIPFAT.AsString;
        qryGen.ParamByName('EMPFAT').AsString := cdsRastroPedRTM_EMPFAT.AsString;
        qryGen.ParamByName('NUMREG').AsString := cdsRastroPedRTM_NUMREG.AsString;

        qryGen.ExecSQL;

        cdsRastroPed.Next;
      End;

      pAtualizaRegistroPedido(strRegCon);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[btnConfirmaDadosClick]');
      End;
    End;
    FreeAndNil(qryGen);
  End;
End;

procedure TfrmDigPedRastreamento.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtNumPedido.Text) Then
  Begin
    fMensagem('', 'O Número do Pedido deve ser preenchido!', ['&Ok']);
    pSetFocus(edtNumPedido);
    Exit;
  End;

  If fEmptyStr(edtNotaFiscal.Text) Then
  Begin
    fMensagem('', 'O Número da Nota Fiscal deve ser preenchido!', ['&Ok']);
    pSetFocus(edtNotaFiscal);
    Exit;
  End;

  If fEmptyStr(edtTipFat.Text) Then
  Begin
    fMensagem('', 'O Tipo de faturamento deve ser preenchido!', ['&Ok']);
    pSetFocus(edtTipFat);
    Exit;
  End;

  If fEmptyStr(edtEmpFat.Text) Then
  Begin
    fMensagem('', 'O Código da Empresa de faturamento deve ser preenchido!', ['&Ok']);
    pSetFocus(edtEmpFat);
    Exit;
  End;

  If (Not fEmptyStr(edtEmpFat.Text)) And (fEmptyStr(fRetNomeEmpresaSelec(edtEmpFat.Text))) Then
  Begin
    fMensagem('', 'O Código da Empresa de faturamento não existe!', ['&Ok']);
    pSetFocus(edtEmpFat);
    Exit;
  End;

  If fEmptyStr(edtNumRegistro.Text) Then
  Begin
    fMensagem('', 'O Número de Registro de Rastreamento deve ser preenchido!', ['&Ok']);
    pSetFocus(edtNotaFiscal);
    Exit;
  End;

  cdsRastroPed.Append;
  cdsRastroPedAUTOINCREM.asString := '';
  cdsRastroPedRTM_CODEMP.asString := VS_strCodEmp;
  cdsRastroPedRTM_NUMDOC.asString := edtNumPedido.Text;
  cdsRastroPedRTM_NUMFAT.asString := edtNotaFiscal.Text;
  cdsRastroPedRTM_TIPFAT.asString := edtTipFat.Text;
  cdsRastroPedRTM_EMPFAT.asString := edtEmpFat.Text;
  cdsRastroPedRTM_NUMREG.asString := edtNumRegistro.Text;
  cdsRastroPed.Post;

  edtNumPedido.Text := strNumDoc;
  edtNotaFiscal.Clear;
  edtNumRegistro.Clear;
  edtTipFat.Clear;
  edtEmpFat.Clear;
  pSetFocus(edtNotaFiscal);
end;

procedure TfrmDigPedRastreamento.btnEnviarEmailClick(Sender: TObject);
  Var
    strRastreios: String;
begin
  inherited;

  If (cdsRastroPed.IsEmpty) Then
    Exit;

  If fMensagem('', 'Deseja enviar os registros de rastreamento para o e-mail do cliente?', ['&Sim', '&Não']) = 2 Then
    Exit;

  strRastreios := '';

  cdsRastroPed.First;
  While Not cdsRastroPed.Eof Do
  Begin
    If (fEmptyStr(strRastreios)) Then
      strRastreios := cdsRastroPedRTM_NUMREG.AsString
    Else
      strRastreios := strRastreios + ', ' + cdsRastroPedRTM_NUMREG.AsString;

    cdsRastroPed.Next;
  End;

  fDisparaEmailAutomatico(strNumDoc,
                          'RE',
                          strEspDoc,
                          '',
                          'ERA',
                          strCodEmp,
                          strCodCli,
                          '',
                          '',
                          Nil,
                          '',
                          '',
                          '',
                          '',
                          '',
                          '',
                          False,
                          False,
                          True,
                          '',
                          strRastreios);
end;

procedure TfrmDigPedRastreamento.btnEnviarWppClick(Sender: TObject);
  Var
    strRastreios: String;
begin
  inherited;

  If (cdsRastroPed.IsEmpty) Then
    Exit;

  If fMensagem('', 'Deseja enviar os registros de rastreamento para o whatsapp do cliente?', ['&Sim', '&Não']) = 2 Then
    Exit;

  strRastreios := '';

  cdsRastroPed.First;
  While Not cdsRastroPed.Eof Do
  Begin
    If (fEmptyStr(strRastreios)) Then
      strRastreios := cdsRastroPedRTM_NUMREG.AsString
    Else
      strRastreios := strRastreios + ', ' + cdsRastroPedRTM_NUMREG.AsString;

    cdsRastroPed.Next;
  End;

  fDisparaWhatsappAutomatico(strNumDoc,
                             'RE',
                             strEspDoc,
                             '',
                             'ERA',
                             strCodEmp,
                             strCodCli,
                             '',
                             True,
                             '',
                             Nil,
                             '',
                             '',
                             '',
                             Self.UnitName,
                             '',
                             '',
                             '',
                             '',
                             '',
                             '',
                             False,
                             False,
                             nil,
                             '',
                             '',
                             nil,
                             '',
                             strRastreios);
end;

procedure TfrmDigPedRastreamento.btnExcluirClick(Sender: TObject);
  Var
    qryGen: TUniQuery;
begin
  inherited;
  If fMensagem('', 'Deseja excluir o registro de rastreamento "'+ String(cdsRastroPedRTM_NUMREG.Value) + '" ?', ['&Sim', '&Não']) = 1 Then
  begin

    Try
      qryGen := fCriaQuery;

      qryGen.SQL.Add('DELETE FROM FATRTM ');
      qryGen.SQL.Add('  WHERE ');
      qryGen.SQL.Add(' AUTOINCREM = :AUTINC ');

      qryGen.ParamByName('AUTINC').AsString := cdsRastroPedAUTOINCREM.AsString;
      qryGen.ExecSQL;

      cdsRastroPed.Delete;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[btnExcluirClick]');
      End;
    End;
    FreeAndNil(qryGen);
  End;
End;

procedure TfrmDigPedRastreamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  cdsRastroPed.Close;
end;

procedure TfrmDigPedRastreamento.FormCreate(Sender: TObject);
begin
  inherited;
  cdsRastroPed.CreateDataSet;
end;

procedure TfrmDigPedRastreamento.FormShow(Sender: TObject);
begin
  inherited;
  pCarregarRegistroRastreamento;
  edtNumPedido.Text := strNumDoc;
  edtTipFat.Text := strEspOri;
  edtEmpFat.Text := strEmpOri;
  edtNotaFiscal.Text := strNumOri;

  btnEnviarWpp.Visible := fCfgSis('UTIWPP', varBoolean) And
                          SameText(fCampoTabela('WPP_STATUS', 'WPPSAI', ['WPP_CODGRU', 'WPP_CODIGO', 'WPP_CODEMP'], ['046', '002', VS_strCodEmp]), 'A');
  btnEnviarEmail.Visible := SameText(fCampoTabela('EMA_STATUS', 'EMASAI', ['EMA_CODGRU', 'EMA_CODIGO', 'EMA_CODEMP'], ['046', '002', VS_strCodEmp]), 'A');

  If fEmptyStr(edtNotaFiscal.Text) Then
    pSetFocus(edtNotaFiscal)
  Else
    pSetFocus(edtNumRegistro);
end;

procedure TfrmDigPedRastreamento.pAtualizaRegistroPedido(strRegCon : String);
  Var
    qryTmp : TUniQuery;
begin
  qryTmp := fCriaQuery(Self);

  Try

    qryTmp.SQL.Add(' UPDATE EXTGOR SET FGO_REGCON = '+QuotedStr(strRegCon));
    qryTmp.SQL.Add(' WHERE FGO_SEQFGO = :SEQFGO  ');
    qryTmp.ParambyName('SEQFGO').AsString := strSeqFgo;
    qryTmp.ExecSQL;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pAtualizaRegistroPedido]');
    End;
  End;

  qryTmp.Close;
  FreeAndNiL(qryTmp);

end;

procedure TfrmDigPedRastreamento.pCarregarRegistroRastreamento;
  Var
    qryTmp : TUniQuery;
begin
  cdsRastroPed.EmptyDataSet;

  qryTmp := fCriaQuery(Self);

  Try

    qryTmp.SQL.Add(' SELECT ');
    qryTmp.SQL.Add('   AUTOINCREM AS AUTINC, ');
    qryTmp.SQL.Add('   RTM_CODEMP AS CODEMP, ');
    qryTmp.SQL.Add('   RTM_NUMDOC AS NUMDOC, ');
    qryTmp.SQL.Add('   RTM_NUMFAT AS NUMFAT, ');
    qryTmp.SQL.Add('   RTM_TIPFAT AS TIPFAT, ');
    qryTmp.SQL.Add('   RTM_EMPFAT AS EMPFAT, ');
    qryTmp.SQL.Add('   RTM_NUMREG AS NUMREG ');
    qryTmp.SQL.Add(' FROM                        ');
    qryTmp.SQL.Add('   FATRTM                    ');
    qryTmp.SQL.Add(' WHERE RTM_CODEMP = :CODEMP  ');
    qryTmp.SQL.Add('   AND RTM_NUMDOC = :NUMDOC  ');
    qryTmp.ParambyName('CODEMP').AsString := VS_strCodEmp;
    qryTmp.ParambyName('NUMDOC').AsString := strNumDoc;
    qryTmp.Open;

    If (Not qryTmp.isEmpty) Then
    Begin
      While Not qryTmp.Eof do
      Begin
        cdsRastroPed.Append;
        cdsRastroPedAUTOINCREM.asString := qryTmp.FieldByName('AUTINC').asString;
        cdsRastroPedRTM_CODEMP.asString := qryTmp.FieldByName('CODEMP').asString;
        cdsRastroPedRTM_NUMDOC.asString := qryTmp.FieldByName('NUMDOC').asString;
        cdsRastroPedRTM_NUMFAT.asString := qryTmp.FieldByName('NUMFAT').asString;
        cdsRastroPedRTM_TIPFAT.asString := qryTmp.FieldByName('TIPFAT').asString;
        cdsRastroPedRTM_EMPFAT.asString := qryTmp.FieldByName('EMPFAT').asString;
        cdsRastroPedRTM_NUMREG.asString := qryTmp.FieldByName('NUMREG').asString;
        cdsRastroPed.Post;
        qryTmp.Next;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmDigPedCmp.pCarregarRegistroRastreamento]');
    End;
  End;

  qryTmp.Close;
  FreeAndNiL(qryTmp);

end;

end.
