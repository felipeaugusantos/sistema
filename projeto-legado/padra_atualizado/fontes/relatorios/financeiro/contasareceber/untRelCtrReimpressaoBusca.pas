unit untRelCtrReimpressaoBusca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, MaskEditFocus, StdCtrls, EditFocus, Menus, Uni,
  Buttons, ExtCtrls, DB, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmRelCtrReimpressaoBusca = class(TfrmPai)
    pnlFundo: TPanel;
    Label1: TLabel;
    lblDesDtaIni: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    edtNumDoc: TEditFocus;
    mskDtaIni: TMaskEditFocus;
    edtCodCliente: TEditFocus;            
    edtDesCliente: TEditFocus;
    btnFiltrar: TBitBtnLocked;
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaCliente(Var qryCadCli: TUniQuery);
    procedure btnFiltrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    qryGenCtr : TUniQuery;

  end;

var
  frmRelCtrReimpressaoBusca: TfrmRelCtrReimpressaoBusca;

implementation

uses untfuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmRelCtrReimpressaoBusca.edtCodClienteExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodCliente.Text) Then
    edtDesCliente.Text := 'TODOS'
  Else
    edtDesCliente.Text := fRetNomCliente(edtCodCliente.Text);

  If fEmptyStr(edtDesCliente.Text) And (Not fEmptyStr(edtCodCliente.Text))  Then
  Begin
    fMensagem('AVISO','Código do cliente não encontrado.', ['&O K']);
    edtCodCliente.Clear;
    pSetFocus(edtCodCliente);
  End;

end;

procedure TfrmRelCtrReimpressaoBusca.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtrReimpressaoBusca.pCarregaCliente(Var qryCadCli: TUniQuery);
Begin
  If Not (fEmptyStr(edtCodCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';
End;

procedure TfrmRelCtrReimpressaoBusca.btnFiltrarClick(Sender: TObject);
  Var
    strFilter: String;
begin
  inherited;

  With qryGenCtr Do
  Begin
    DisableControls;

    strFilter := '';

    If Not fEmptyStr(edtNumDoc.Text) Then
    Begin

      strFilter := strFilter + 'CTR_NUMDUP = ' + QuotedStr(edtNumDoc.Text);

    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin

      If Not fEmptyStr(strFilter) Then
        strFilter := strFilter + ' AND ';

      strFilter := strFilter + 'CTR_DTACAD = ' + QuotedStr(FormatDateTime('YYYY-MM-DD', StrToDate(mskDtaIni.Text)));
    End;

    If Not fEmptyStr(edtCodCliente.Text) Then
    Begin

      If Not fEmptyStr(strFilter) Then
        strFilter := strFilter + ' AND ';

      strFilter := strFilter + 'CTR_CODCLI = ' + QuotedStr(edtCodCliente.Text);

    End;

    If fEmptyStr(strFilter) Then
    Begin
      Filtered := False;
      Filter   := '';
    End Else
    Begin
      Filter   := strFilter;
      Filtered := True;
    End;

    EnableControls;
  End;

  Close;
end;

end.

