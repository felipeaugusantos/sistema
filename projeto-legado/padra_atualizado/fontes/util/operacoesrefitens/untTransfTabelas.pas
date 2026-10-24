unit untTransfTabelas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, ComCtrls,  untTransfereTabelas, frxClass, frxExportCSVTestabilidade;

type
  TfrmTransfTabelas = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    prgProgresso: TProgressBar;
    cbxTabOri: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    cbxTabDes: TComboBox;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    objTraTab: TTransfereTabelas;

    procedure pCarregaTabPre(cbxTabPre: TComboBox; blnFiltraPrimeira: Boolean);
  public
    { Public declarations }
  end;

var
  frmTransfTabelas: TfrmTransfTabelas;

implementation
uses
    untFuncoesSimples;

{$R *.dfm}

procedure TfrmTransfTabelas.btnConfirmaClick(Sender: TObject);
var blnValidaForPri: Boolean;
    strCfgTBOFPC: String;
    strTabelasMsg: String;
    i: integer;
begin
  inherited;
  If cbxTabOri.ItemIndex < 0 Then
  Begin
    pMensagemOk('Selecione a Tabela de Preço origem!');
    Exit;
  End;

  If cbxTabDes.ItemIndex < 0 Then
  Begin
    pMensagemOk('Selecione a Tabela de Preço Destino!');
    Exit;
  End;

  If cbxTabDes.Text = cbxTabOri.Text Then
  Begin
    pMensagemOk('A Tabela Origem deve ser diferente da Tabela Destino!');
    Exit;
  End;

  strCfgTBOFPC := fCfgSis('TBOFPC');

  strCfgTBOFPC := fCfgSis('TBOFPC');
  For i := 1 To 7 do
  Begin
    If strCfgTBOFPC[i] = 'S' Then
      strTabelasMsg := strTabelasMsg + IntToStr(i) + ',';
  End;

  strTabelasMsg := Copy(strTabelasMsg, 1,Length(strTabelasMsg) -1);


  blnValidaForPri := False;
  If strCfgTBOFPC[StrToInt(cbxTabDes.Text)] = 'S' Then
  Begin
    fMensagem('Atenção', 'O(s) Preço(s) de Venda ' + strTabelasMsg  + ' estão com Obrigatoriedade do Fornecedor Principal na ' + #13 +
                'Configuração: CFG_TBOFPC(Obrigar que a Tabela de Preço do Fornecedor Ativa, ' + #13 +
                'ou que será Ativada para o Custo, Tenha o mesmo Fornecedor da Tabela de Preço, do Fornecedor Principal).' + #13 +
                'Os Itens que não obedecerem essa Regra, NÃO serão atualizados.', ['OK'],
                1,
                False,
                1,
                0,
                false,
                0,
                False,
                False,
                False,
                0,
                600);
    blnValidaForPri := True;
  End;


  If fPergunta('Confirma a Transferência de Preços da Tabela ' + cbxTabOri.Text + ' para a Tabela ' + cbxTabDes.Text + ' ? ') And
     objTraTab.fTransferePrecos(StrToIntDef(cbxTabOri.Text, 0), StrToIntDef(cbxTabDes.Text, 0), blnValidaForPri) Then
  Begin
    pMensagemOk('Operação realizada com sucesso!');
    Close;
  End;  
end;


procedure TfrmTransfTabelas.pCarregaTabPre(cbxTabPre: TComboBox; blnFiltraPrimeira: Boolean);
  Var
    intIndex: Integer;
Begin
  cbxTabPre.Items.Clear;

  For intIndex := 1 To Length(VS_strTabPrc) Do

    If (VS_strTabPrc[intIndex] = 'S') And
       ((Not blnFiltraPrimeira) Or (fRetPrimeiraTabPrecoAtiva <> intIndex)) Then
      cbxTabPre.Items.Add(IntToStr(intIndex));

  cbxTabPre.ItemIndex := -1;
End;

procedure TfrmTransfTabelas.FormCreate(Sender: TObject);
begin
  inherited;

  pCarregaTabPre(cbxTabOri, False);

  pCarregaTabPre(cbxTabDes, False);

  objTraTab := TTransfereTabelas.Create(prgProgresso, pnlInfo);
end;

procedure TfrmTransfTabelas.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(objTraTab);
end;

procedure TfrmTransfTabelas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: Close;
    VK_RETURN: If ActiveControl Is TComboBox Then
                SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmTransfTabelas.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(cbxTabOri);

end;

end.
