unit untMsgValidacaoGeracaoOrcPed;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.StdCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls;

type
  TValidaEmp = (veValidaSomenteEmp, veValida, veNaoValida);

  TfrmMsgValidacaoGeraOrdOp = class(TfrmPai)
    mmoMsg: TMemo;
    class function fMsgValidacaoGeracaoOrcPed(veValidaEmp: TValidaEmp; strCodEmp: String; blnEmpSelIgualEmpLog: Boolean): boolean;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMsgValidacaoGeraOrdOp: TfrmMsgValidacaoGeraOrdOp;


implementation

{$R *.dfm}

uses untFuncoesSimples, untFuncoes;

{ TfrmMessageOKDimenAuto }

class function TfrmMsgValidacaoGeraOrdOp.fMsgValidacaoGeracaoOrcPed(veValidaEmp: TValidaEmp;
  strCodEmp: String; blnEmpSelIgualEmpLog: Boolean): boolean;
var frmMessageOK: TfrmMsgValidacaoGeraOrdOp;
    Lista: TStringList;

  procedure pErroPorParametro(Parametro_Nome: string);
  begin
    If Parametro_Nome = 'MSMEMP' then
    Begin
      Lista.Add('Não é possível gerar Pedidos/Orçamentos de Transferência de Estoque para a própria empresa.');
      Lista.Add('');
    End
    Else If Parametro_Nome = 'FPORPD' then
    Begin
      Lista.Add('Para gerar ordem ou pedido é preciso configurar a Forma de Pagamento. Acessar CONFIGURAÇÕES DO SISTEMA, aba PRODUTOS,');
      Lista.Add('e cadastrar uma forma de pagamento da configuração "Geração de PD/OR para abastecimento de Itens para Reposição - Código Forma de Pagamento para Geração de OR/PD.');
      Lista.Add('');
    End
    Else if Parametro_Nome = 'CCONPG'  then
    begin
      Lista.Add('Para gerar ordem ou pedido é preciso configurar a Condição de Pagamento. Acessar CONFIGURAÇÕES DO SISTEMA, aba PRODUTOS,');
      Lista.Add(' e cadastrar uma forma de pagamento da configuração "Geração de PD/OR para abastecimento de Itens para Reposição - Condição de Pagamento para Geração de OR/PD ( quando utiliza tabela de condição de Pagamento )');
      Lista.Add('');
    end
    Else if Parametro_Nome = 'CNDORP'  then
    begin
      Lista.Add('Para gerar ordem ou pedido é preciso configurar a Condição de Pagamento. Acessar CONFIGURAÇÕES DO SISTEMA, aba PRODUTOS,');
      Lista.Add('e cadastrar uma forma de pagamento da configuração "Geração de PD/OR para abastecimento de Itens para Reposição - Condição de Pagamento para Geração de OR/PD ( quando não utiliza tabela de condição de Pagamento )');
    end
    Else if Parametro_Nome = 'FPORPDSQL' then
    Begin
      Lista.Add('Este código da Forma de Pagamento não exite.');
      Lista.Add('Acessar CONFIGURAÇÕES DO SISTEMA, aba PRODUTOS,');
      Lista.Add('e cadastrar uma forma de pagamento da configuração "Geração de PD/OR para abastecimento de Itens para Reposição - Código Forma de Pagamento para Geração de OR/PD.');
      Lista.Add('');
    End
    Else if Parametro_Nome = 'CCONPGSQL' then
    Begin
      Lista.Add('Código da Condição de Pagamento não existe.');
      Lista.Add('Acessar CONFIGURAÇÕES DO SISTEMA, aba PRODUTOS,');
      Lista.Add(' e cadastrar uma forma de pagamento da configuração "Geração de PD/OR para abastecimento de Itens para Reposição - Condição de Pagamento para Geração de OR/PD ( quando utiliza tabela de condição de Pagamento )');
      Lista.Add('');
    End;
  end;
Begin
  Result := False;
  Try
    Try
      Lista := TStringList.Create;

      If (veValidaEmp <> veNaoValida) And (fEmptyStr(strCodEmp) Or blnEmpSelIgualEmpLog) Then
        pErroPorParametro('MSMEMP');

      If veValidaEmp <> veValidaSomenteEmp Then
      Begin
        If fEmptyStr(fCfgSis('FPORPD', varString)) then
           pErroPorParametro('FPORPD')
        Else
        If fCampoTabela('COUNT(1)', 'CADFPG', ['FPG_CODIGO'], [fCfgSis('FPORPD', varString)], False) = 0 then
           pErroPorParametro('FPORPDSQL');

        If fCfgSis('USACND', varBoolean) then
        Begin
          If (fCfgSis('CCONPG', varString) = '') then
             pErroPorParametro('CCONPG')
          Else If fCampoTabela('CND_CNDPAG', 'CADCND', ['CND_CODIGO'], [fCfgSis('CCONPG', varString)], False) = '' then
             pErroPorParametro('CCONPGSQL');
        End
        Else If (fCfgSis('CNDORP', varString)= '') then
             pErroPorParametro('CNDORP');
      End;

      Result := fEmptyStr(Lista.Text);

      If not Result then
      Begin
        frmMessageOK := TfrmMsgValidacaoGeraOrdOp.Create(nil);
        Try
          frmMessageOK.mmoMsg.Text := Lista.Text;
          frmMessageOK.ShowModal;
        Finally
          pFreeAndNil(frmMessageOK);
        End;
      end;
    Except
      on E: Exception do
         pMensagensErro(e.Message, '[TfrmMsgValidacaoGeraOrdOp.fMsgValidacaoGeracaoOrcPed]');
    end;
  Finally
    FreeAndNil(Lista);
  End;
end;

procedure TfrmMsgValidacaoGeraOrdOp.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_ESCAPE Then
    Close;
end;

end.
