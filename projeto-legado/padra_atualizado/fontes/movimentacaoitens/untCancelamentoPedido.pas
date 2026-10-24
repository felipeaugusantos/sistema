{******************************}
{* qryConEmp -> CADEMP        *}
{***************************JB*}

unit untCancelamentoPedido;

interface

uses
  Windows, Classes, Controls, Forms, StdCtrls, untPaiSimples, EditFocus, ComCtrls,
  Buttons, Uni, ExtCtrls, Menus, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untInicializaDllPedido, untTypesSistema;

type
  TfrmCancelamentoPedido = class(TfrmPaiSimples)
    edtNumPed: TEditFocus;
    lblPedOrc: TLabel;
    edtCodEmp: TEditFocus;
    Label1: TLabel;
    edtNomEmp: TEditFocus;
    pnlFundo: TPanel;
    rdgOpcoes: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure edtNumPedKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryConEmp: TUniQuery;

    procedure pCarregaEmpresa;
    procedure OnIdle(Sender: TObject; var Done: Boolean);

    function fVerificaSePedidoEImportacaoJaPossuiDocVinculado(strNumPed, strEspPed, strCodEmp: String; Var strNumDoc: String): Boolean;
    function fTemLayoutImpressao: Boolean;
  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
  end;


implementation

uses SysUtils, untFuncoes, untFuncoesSimples, untPesqAux, untModulo, untConsultas,
  untPcmGer, untFatGor, untFuncoesRel2, untFuncoesPedidoSimples;

{$R *.dfm}

function TfrmCancelamentoPedido.fTemLayoutImpressao: Boolean;
Var
  qryModelo: TUniQuery;

Begin
  qryModelo := fCriaQuery;
  Try
    qryModelo.SQL.Add('SELECT LAY_CODLAY FROM LAYETI');
    qryModelo.SQL.Add(' WHERE LAY_TIPLAY = "214"');
    qryModelo.SQL.Add('   AND LAY_PADRAO = "S"');
    qryModelo.SQL.Add('   AND LAY_CODEMP = "'+edtCodEmp.Text+'"');
    qryModelo.Open;
    Result := (Not qryModelo.IsEmpty);
  Finally
    FreeAndNil(qryModelo);
  End;

end;

function TfrmCancelamentoPedido.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strEspDoc: String;
    strDesEsp: String;
    strNotas: string;
    blnBonificacao,
    blnLiberado,
    blnConferido,
    blnBaixado,
    blnOriundo,
    blnImportado,
    blnMaisDeUm,
    blnOriundoImportacaoNotaEletronica: Boolean;
    strEmpDes,
    strEmpres,
    strCodFor,
    strPreNot,
    strAutInc,
    strNumDoc: String;
    opcRequisicao: TOpcRequisicao;
    intMotivoReq: Integer;
    strMotivoReq: String;
   // hwdDllPedido: Cardinal;
    strTrava : String;
begin

  opcRequisicao := opcSemRequisicao;
  intMotivoReq := -1;
  strMotivoReq := '';
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumPed) Then
    Begin
      Result := False;

      If rdgOpcoes.ItemIndex = 0 Then
      Begin
        strEspDoc := 'PD';
        strDesEsp := 'Pedido';
      End
      Else
      Begin
        strEspDoc := 'OR';
        strDesEsp := 'Orçamento';
      End;

      edtNumPed.Enabled := False;

      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        edtCodEmp.Text := VS_strCodEmp;
        pCarregaEmpresa;
      End;

      If fEmptyStr(edtNumPed.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Número do ' + strDesEsp + ' deve ser preenchido!', ['&O k']);
      End
      Else If Not fPedidoCompraCadastrado(edtNumPed.Text, edtCodEmp.Text, strEspDoc, blnBonificacao,
        blnLiberado, blnConferido, blnBaixado, blnOriundo, blnImportado, blnMaisDeUm,
        strEmpDes, strEmpres, strCodFor, strPreNot, strAutInc, blnOriundoImportacaoNotaEletronica) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse ' + strDesEsp + ' não está cadastrado!', ['&Ok']);
      End
      Else
      If fVerificaSePedidoEImportacaoJaPossuiDocVinculado(edtNumPed.Text, strEspDoc, edtCodEmp.Text, strNumDoc) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Pedido informado não pode ser cancelado, pois, o mesmo é de importação e possui a Nota Fiscal: '+strNumDoc+' vinculada!', ['&Ok']);
      End
      Else If blnBaixado Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse ' + strDesEsp + ' já está baixado!', ['&Ok']);
      End

      Else If (strEspDoc = 'PD') And fTemPreNotaPedido(edtNumPed.Text, edtCodEmp.Text, strNotas) Then
      Begin
        pMensagemOk('Esse pedido já está associado à(s) pré-nota(s) '+ strNotas + ' e' + #13#10 +
                    'somente poderá ser alterado após a entrada de mercadorias (se parcial) ou' + #13#10 +
                    'cancelamento da(s) pré-nota(s).');
      End

      Else If (strEspDoc = 'PD') And blnOriundoImportacaoNotaEletronica Then
      Begin
        pMensagemOk('Esse pedido de compra está associado à Importação de Nota Fiscal Eletrônica e' + #13#10 +
                    'não pode ser cancelado.');
      End

      Else
      Begin
        If (fTemLayoutImpressao) And
           (fMensagem('ATENÇÃO!', 'Deseja imprimir o pedido de compra?', ['&Sim', '&Não']) = 1) Then
        Begin
          pImprimePedidoCompraAutCom(edtNumPed.Text,
                                     strEspDoc,
                                     edtCodEmp.Text);  //blnReimpr
        End;

        Result := True;
        strTrava := 'PEDCOM' + edtNumPed.Text + strEspDoc + edtCodEmp.Text;

        if not fLock_Unlock(strTrava, True, False) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strTrava), ['&Ok']);
        End;

        If Result then
        Begin

          If fValidaSeDocumentoPodeSerBaixado(edtNumPed.Text, strEspDoc, edtCodEmp.Text, strAutInc, opcRequisicao, intMotivoReq, strMotivoReq) Then
          Begin
            If (fMensagem('ATENÇÃO!', 'Confirma cancelamento?', ['&Sim', '&Não']) = 1) And fDeletaPedido(edtNumPed.Text, edtCodEmp.Text, strEspDoc) Then
            Begin
              fMensagem('ATENÇÃO!', strDesEsp + ' cancelado com sucesso!', ['&O k']);
              edtNumPed.Clear;
            End;

          End;
        End;

        If Result Then
          fLock_Unlock(strTrava, False, False);
      End;

      edtNumPed.Enabled := True;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        //edtNomEmp.Text := 'TODAS';
        edtCodEmp.Text := VS_strCodEmp;
        pCarregaEmpresa;
      End
      Else
      Begin
        pCarregaEmpresa;
        If (fEmptyStr(edtNomEmp.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmCancelamentoPedido.fVerificaSePedidoEImportacaoJaPossuiDocVinculado(strNumPed, strEspPed, strCodEmp: String; Var strNumDoc: String): Boolean;
  Var
    qryPedImp: TUniQuery;
Begin

  qryPedImp   := fCriaQuery;
  Try

    If rdgOpcoes.ItemIndex = 0 Then //Verifica se é Pedido ou Orçamento
    Begin
      qryPedImp.Close;
      qryPedImp.SQL.Clear;

      qryPedImp.SQL.Add('SELECT PCG_CODEMP, PCG_NUMPED, PCG_ESPDOC, PCG_DOCEMI FROM PCMGER ');
      qryPedImp.SQL.Add('WHERE PCG_NUMPED = :NUMPED AND  ');
      qryPedImp.SQL.Add('      PCG_CODEMP = :CODEMP AND  ');
      qryPedImp.SQL.Add('      PCG_ESPDOC = :ESPPED AND  ');
      qryPedImp.SQL.Add('      PCG_PEDIMP = "S"     AND  ');
      qryPedImp.SQL.Add('      PCG_DOCEMI IS NOT NULL    ');

      qryPedImp.ParamByName('NUMPED').AsString := strNumPed;
      qryPedImp.ParamByName('CODEMP').AsString := strCodEmp;
      qryPedImp.ParamByName('ESPPED').AsString := strEspPed;

      qryPedImp.Open;

      strNumDoc:= qryPedImp.FieldByName('PCG_DOCEMI').AsString;

      Result:= Not(qryPedImp.IsEmpty)
    End
    Else
      Result:= False;

  Finally
    FreeAndNil(qryPedImp);
  End;

End;

procedure TfrmCancelamentoPedido.pEscapePressed;
begin

  If (edtNumPed.Focused) Then
    SelectNext(ActiveControl,False,True)
  Else
    inherited;

end;

procedure TfrmCancelamentoPedido.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  With qryConEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmCancelamentoPedido.FormCreate(Sender: TObject);
begin
  inherited;
  edtCodEmp.Text := VS_strCodEmp;
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  pCarregaEmpresa;

  If (fCfgSis('EMPGER', varBoolean)) Then
    edtCodEmp.Enabled := True;

  Application.OnIdle := Self.OnIdle;

  edtNumPed.MaxLength := fTamDocCadRec();
  edtNumPed.TamCampo  := edtNumPed.MaxLength;
end;

procedure TfrmCancelamentoPedido.edtNumPedKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrPedido: TConsultasArray;
begin
  inherited;

  {**********************************}
  {* NOVA CONSULTA DE PEDIDO COMPRA *}
  {*******************************AC*}
  fPesqPedidoCompraCancelPedido(Self, edtNumPed, rdgOpcoes, edtCodEmp, Nil, Key, arrPedido);
end;

procedure TfrmCancelamentoPedido.OnIdle(Sender: TObject; var Done: Boolean);
begin

  If (rdgOpcoes.ItemIndex = 0) Then
  Begin
    lblPedOrc.Caption := 'Pedido para cancelar:';
  End
  Else
  Begin
    lblPedOrc.Caption := 'Orçam. para cancelar:';
  End;

end;

procedure TfrmCancelamentoPedido.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Application.OnIdle := Nil;
end;

procedure TfrmCancelamentoPedido.FormShow(Sender: TObject);
begin
  inherited;

 // SelectNext(ActiveControl,False,True);

end;

procedure TfrmCancelamentoPedido.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_ESCAPE) Then
  Begin
    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
    Begin
      Close;
    End;
  End
  Else If (Key = VK_RETURN) Then
  Begin
    If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
    Begin
      If edtCodEmp.Enabled Then
        pSetFocus(edtCodEmp)
      Else
        pSetFocus(edtNumPed);
    End;
  End;

end;

procedure TfrmCancelamentoPedido.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.





