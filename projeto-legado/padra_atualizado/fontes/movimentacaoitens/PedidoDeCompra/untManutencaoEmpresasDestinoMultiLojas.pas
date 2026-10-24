unit untManutencaoEmpresasDestinoMultiLojas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus, Uni,
  untFuncoesSimples, untConsultas, untConstantes, untTypesSistema, untFuncoesConsulta,
  untPaiConfirma, Data.DB;

type
  TfrmManutencaoEmpresasDestinoMultiLojas = class(TfrmPai)
    pnlDocOrigem: TPanel;
    pnlDocEncontrado: TPanel;
    lblPedOrc: TLabel;
    edtNumPed: TEditFocus;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmpresaDestino: TEditFocus;
    edtDesEmpresaDestino: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    edtCodFor: TEditFocus;
    edtDesFor: TEditFocus;
    Label3: TLabel;
    edtDtaEmissao: TEditFocus;
    Label4: TLabel;
    edtDtaEntrega: TEditFocus;
    Label5: TLabel;
    edtCodEmpresaDestinoNova: TEditFocus;
    edtDesEmpresaNova: TEditFocus;
    Label6: TLabel;
    edtValorPedido: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumPedKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodEmpresaDestinoNovaKeyPress(Sender: TObject; var Key: Char);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fCarregaPedido: Boolean;
    procedure pHabilitarTroca(blnHabilita: Boolean);
    procedure pAtualizaEmpresaDestino;

  private
    qryConsulta : TUniQuery;
    arrSel,
    arrLinEmp: TConsultasArray;
    strAutoincrem: string;
    strTrava: string;
    blnTravou: Boolean;
    procedure pPreencheCampos;
    procedure pLimpaCampos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmManutencaoEmpresasDestinoMultiLojas: TfrmManutencaoEmpresasDestinoMultiLojas;

implementation


{$R *.dfm}

procedure TfrmManutencaoEmpresasDestinoMultiLojas.btnConfirmaClick(
  Sender: TObject);
begin
    If (edtCodEmpresaDestinoNova.Text <> edtCodEmpresaDestino.Text) And
     (Not fEmptyStr(edtCodFor.Text)) And
     (Not fEmptyStr(edtCodEmpresaDestinoNova.Text)) Then
  Begin
    pAtualizaEmpresaDestino;
    If blnTravou Then
    Begin
      fLock_Unlock(strTrava, False, False);
      blnTravou := False;
    End;
    pLimpaCampos;
  End
  Else
    fVerificaCampos
end;

procedure TfrmManutencaoEmpresasDestinoMultiLojas.edtCodEmpresaDestinoNovaKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresaDestinoNova, edtDesEmpresaNova, Nil, Key, arrLinEmp, True, True) Then
    fValidaCampos(edtCodEmpresa, False);

end;

procedure TfrmManutencaoEmpresasDestinoMultiLojas.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrLinEmp, True, True) Then
    fValidaCampos(edtCodEmpresa, False);
end;

procedure TfrmManutencaoEmpresasDestinoMultiLojas.edtNumPedKeyPress(Sender: TObject; var Key: Char);
var strEspDoc: string;
begin
  inherited;
  strEspDoc := 'PD';

  If fPesqPedidoCompra(Self, edtNumPed, qryConsulta, Key, arrSel, strEspDoc, edtCodEmpresa.Text, 0, False, nil, STR_LITRO_GALAO) Then
  Begin
    edtCodEmpresa.text := qryConsulta.FieldByName('PCG_CODEMP').AsString;
    edtCodEmpresaDestino.Text := qryConsulta.FieldByName('PCG_EMPDES').AsString;
    edtDesEmpresaDestino.Text := fRetNomeEmpresaSelec(edtCodEmpresaDestino.Text);

    fValidaCampos(edtCodEmpresa);
  End;
end;

procedure TfrmManutencaoEmpresasDestinoMultiLojas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If blnTravou Then
  Begin
    Action := caNone;
    fLock_Unlock(strTrava, False, False);
    blnTravou := False;
    pLimpaCampos;
    pSetFocus(edtNumPed);
  End
end;

procedure TfrmManutencaoEmpresasDestinoMultiLojas.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta := fCriaQuery;
  edtNumPed.TamCampo  := fTamNumPedCom;
  blnTravou := False;
  strTrava := '';
  strAutoincrem := '';
end;

procedure TfrmManutencaoEmpresasDestinoMultiLojas.FormDestroy(Sender: TObject);
begin
  If blnTravou Then
    fLock_Unlock(strTrava, False, False);
  FreeAndNil(qryConsulta);
  inherited;

end;

procedure TfrmManutencaoEmpresasDestinoMultiLojas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
    btnConfirmaClick(Sender);
end;

procedure TfrmManutencaoEmpresasDestinoMultiLojas.FormShow(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
end;

function TfrmManutencaoEmpresasDestinoMultiLojas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If Sender = edtNumPed Then
  Begin
    If fEmptyStr(edtNumPed.Text) Then
    Begin
      Result := False;
      pMensagemOk('O Pedido deve ser informado!');
    End;
  End
  Else If Sender = edtCodEmpresa Then
  Begin
    If edtCodEmpresa.Text = '' Then
    Begin
      Result := False;
      pMensagemOk('A Empresa do pedido deve ser informada!');
    End
    Else
    Begin
      edtDesEmpresa.text :=  fRetNomeEmpresa(edtCodEmpresa.Text);
      If fEmptyStr(edtDesEmpresa.Text) Then
      Begin
        Result := False;
        pMensagemOk('A Empresa informada não foi identificada.');
      End;
      If Result Then
      Begin
        If fCarregaPedido Then
        Begin
          If qryConsulta.FieldByName('BAIXAD').AsInteger = 1 Then
          Begin
            pMensagemOk('O Pedido Selecionado contem itens baixados.');
            Result := False;
          End;
          If qryConsulta.FieldByName('PRENOT').AsInteger = 1 Then
          Begin
            pMensagemOk('O Pedido Selecionado esta em pré-nota.');
            Result := False;
          End;
          If Result Then
          begin
            If Not blnTravou Then
            Begin
              strTrava := 'PEDCOM' + edtNumPed.Text +  'PD' + edtCodEmpresa.Text;
              If (Not fLock_Unlock(strTrava, True, False)) Then
              Begin
                Result := False;
                fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strTrava), ['&Ok']);
              End
              Else
                blnTravou := True;
            End;
          End;
          pHabilitarTroca(Result);
          If Result Then
          Begin
            pPreencheCampos;
            blnMudarFoco := False;
            pSetFocus(edtCodEmpresaDestinoNova);
          End;
        End;
      End;
    End;
  End
  Else If Sender = edtCodEmpresaDestinoNova Then
  Begin
    If edtCodEmpresaDestinoNova.Text = '' Then
    Begin
      Result := False;
      pMensagemOk('A Empresa de Destino Nova deve ser informada!');
    End
    Else
    Begin
      edtDesEmpresaNova.text :=  fRetNomeEmpresa(edtCodEmpresaDestinoNova.Text);
      If fEmptyStr(edtDesEmpresaNova.Text) Then
      Begin
        Result := False;
        pMensagemOk('A Empresa de Destino Nova não foi identificada.');
      End
      Else If edtCodEmpresaDestinoNova.Text = edtCodEmpresaDestino.Text Then
      Begin
        Result := False;
        pMensagemOk('A Empresa de Destino Nova informada é igual a atual.')
      End;
    End;
  End;
end;

function TfrmManutencaoEmpresasDestinoMultiLojas.fCarregaPedido: Boolean;
begin
  Try
    strAutoincrem := '';
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT PCMGER.AUTOINCREM,');
    qryConsulta.SQL.Add('       PCG_CODFOR,');
    qryConsulta.SQL.Add('       FOR_NOMFOR,');
    qryConsulta.SQL.Add('       PCG_CODEMP,');
    qryConsulta.SQL.Add('       PCG_EMPDES,');
    qryConsulta.SQL.Add('       PCG_DTAPED,');
    qryConsulta.SQL.Add('       PCG_DTAENT,');
    qryConsulta.SQL.Add('       PCG_TOTGER,');
    qryConsulta.SQL.Add('       IF(PCG_BAIXAD = 0, (SELECT COUNT(1)');
    qryConsulta.SQL.Add('                             FROM PCMDET');
    qryConsulta.SQL.Add('                            WHERE PCD_NUMPED = PCG_NUMPED');
    qryConsulta.SQL.Add('                              AND PCD_CODEMP = PCG_CODEMP');
    qryConsulta.SQL.Add('                              AND PCD_ESPDOC = "PD"');
    qryConsulta.SQL.Add('                              AND IFNULL(PCD_QTDBAI, 0) > 0) > 0  ,PCG_BAIXAD) AS BAIXAD,');
    qryConsulta.SQL.Add('       (SELECT COUNT(1)');
    qryConsulta.SQL.Add('          FROM PEDELE');
    qryConsulta.SQL.Add('         WHERE PEL_NUMDOC =  PCG_NUMPED');
    qryConsulta.SQL.Add('           AND PEL_ESPDOC = "PD"');
    qryConsulta.SQL.Add('           AND PEL_CODEMP = PCG_CODEMP');
    qryConsulta.SQL.Add('           AND PEL_CODFOR = PCG_CODFOR) > 0 AS PRENOT');
    qryConsulta.SQL.Add('FROM PCMGER');
    qryConsulta.SQL.Add('INNER JOIN CADFOR ON FOR_CODFOR = PCG_CODFOR');
    qryConsulta.SQL.Add('WHERE PCG_ESPDOC = "PD"');
    qryConsulta.SQL.Add('  AND PCG_NUMPED = :NUMPED');
    qryConsulta.SQL.Add('  AND PCG_CODEMP = :CODEMP');
    qryConsulta.SQL.Add('  AND PCG_EMPDES IS NOT NULL');
    qryConsulta.ParamByName('NUMPED').AsString := edtNumPed.Text;
    qryConsulta.ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
    qryConsulta.Open;
    Result := Not qryConsulta.IsEmpty;
    If Not Result Then
    Begin
      pMensagemOk('Pedido: ' + edtNumPed.Text + ' - ' +
                  'Empresa: ' + edtCodEmpresa.Text + ' - ' +
                  ' não foi localizado.');
      pSetFocus(edtNumPed);
    End
    Else
      strAutoincrem := qryConsulta.FieldByName('AUTOINCREM').AsString;
  Except
    on E:Exception do
    Begin
      Result := False;
      pMensagensErro(e.Message, '[TfrmManutencaoEmpresasDestinoMultiLojas.pCarregaPedido]');
    End;
  End;
end;

procedure TfrmManutencaoEmpresasDestinoMultiLojas.pAtualizaEmpresaDestino;
begin
  Try
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('UPDATE PCMGER');
    qryConsulta.SQL.Add('  SET PCG_EMPDES = :EMPDES_NOVA');
    qryConsulta.SQL.Add('WHERE PCG_NUMPED = :NUMPED');
    qryConsulta.SQL.Add('  AND PCG_CODEMP = :CODEMP');
    qryConsulta.SQL.Add('  AND PCG_ESPDOC = "PD"');
    qryConsulta.SQL.Add('  AND PCG_CODFOR = :CODFOR');
    qryConsulta.ParamByName('EMPDES_NOVA').AsString := edtCodEmpresaDestinoNova.Text;
    qryConsulta.ParamByName('NUMPED').AsString := edtNumPed.Text;
    qryConsulta.ParamByName('CODEMP').AsString := edtCodEmpresa.Text;
    qryConsulta.ParamByName('CODFOR').AsString := edtCodFor.Text;

    qryConsulta.ExecSQL;

    If strAutoincrem <> '' Then
    Begin
      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('UPDATE CADINT SET INT_VALCOM = "' + edtCodEmpresaDestinoNova.Text +'"');
      qryConsulta.SQL.Add(' WHERE INT_VALKEY = "'+strAutoincrem+'"');
      qryConsulta.SQL.Add('   AND INT_NOMCOM IN("cxGrid", "EMPVIS")');
      qryConsulta.ExecSQL;
    End;

    pMensagemOk('Alteração realizada com suscesso!');
    pLimpaCampos;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmManutencaoEmpresasDestinoMultiLojas.pAtualizaEmpresaDestino]');
  End;
end;

procedure TfrmManutencaoEmpresasDestinoMultiLojas.pHabilitarTroca(
  blnHabilita: Boolean);
begin
  pnlDocOrigem.Enabled := Not blnHabilita;
end;

procedure TfrmManutencaoEmpresasDestinoMultiLojas.pPreencheCampos;
begin
  edtCodFor.Text := qryConsulta.FieldByName('PCG_CODFOR').AsString;
  edtDesFor.Text := qryConsulta.FieldByName('FOR_NOMFOR').AsString;
  edtDtaEmissao.Text  := qryConsulta.FieldByName('PCG_DTAPED').AsString;
  edtDtaEntrega.Text  := qryConsulta.FieldByName('PCG_DTAENT').AsString;
  edtCodEmpresaDestino.Text := qryConsulta.FieldByName('PCG_EMPDES').AsString;
  edtDesEmpresaDestino.Text := fRetNomeEmpresaSelec(edtCodEmpresaDestino.Text);

  edtValorPedido.Text := FormatFloat('#0.00', qryConsulta.FieldByName('PCG_TOTGER').AsFloat);
end;

procedure TfrmManutencaoEmpresasDestinoMultiLojas.pLimpaCampos;
begin
  edtNumPed.Clear;
  edtCodEmpresa.Clear;
  edtDesEmpresa.Clear;
  edtCodEmpresaDestino.Clear;
  edtDesEmpresaDestino.Clear;
  edtCodFor.Clear;
  edtDesFor.Clear;
  edtDtaEmissao.Clear;
  edtDtaEntrega.Clear;
  edtValorPedido.Clear;
  edtCodEmpresaDestinoNova.Clear;
  edtDesEmpresaNova.Clear;
  pSetFocus(edtNumPed);
  pHabilitarTroca(False);
  strAutoincrem := '';
end;


end.
