unit untReimpressaoDocsBusca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  Mask, MaskEditFocus, EditFocus, DB, Uni, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmReimpressaoDocsBusca = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    Label1: TLabel;
    edtNumDoc: TEditFocus;
    lblDesDtaIni: TLabel;
    Label12: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label2: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    pnlButtons: TPanel;
    btnFiltrar: TBitBtnLocked;
    BitBtn1: TBitBtnLocked;
    edtValor: TEditFocus;
    Label3: TLabel;
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure btnSairClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure pCarregaCliente(Var qryCadCli: TUniQuery);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmReimpressaoDocsBusca: TfrmReimpressaoDocsBusca;

implementation

uses untfuncoesSimples, untReimpressaoDocsList, UniClientDataSet, untConsultas,
  untTypesSistema;

{$R *.dfm}

procedure TfrmReimpressaoDocsBusca.edtCodClienteExit(Sender: TObject);
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

procedure TfrmReimpressaoDocsBusca.edtCodClienteKeyPress(Sender: TObject;
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

procedure TfrmReimpressaoDocsBusca.FormActivate(Sender: TObject);
begin
  inherited;
  Application.ProcessMessages;
  SelectFirst;
  edtNumDoc.SelectAll;
end;

procedure TfrmReimpressaoDocsBusca.FormCreate(Sender: TObject);
begin
  inherited;

  edtNumDoc.MaxLength := fTamDocCadRec();
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;
end;

procedure TfrmReimpressaoDocsBusca.pCarregaCliente(Var qryCadCli: TUniQuery);
Begin
  If Not (fEmptyStr(edtCodCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';
End;

procedure TfrmReimpressaoDocsBusca.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmReimpressaoDocsBusca.btnFiltrarClick(Sender: TObject);
  Var
    strFiltro: String;
begin
  inherited;

  strFiltro := '';

  If Not fEmptyStr(edtNumDoc.Text) Then
    strFiltro := strFiltro + 'NUMDOC = ' + QuotedStr(edtNumDoc.Text) + ' AND ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    strFiltro := strFiltro + 'DTAENT = ' + QuotedStr(FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaIni.Text))) + ' AND ';

  If Not fEmptyStr(edtCodCliente.Text) Then
    strFiltro := strFiltro + 'CODCLI = ' + QuotedStr(edtCodCliente.Text) + ' AND ';

  If fStrToFloat(edtValor.Text) > 0 Then
    strFiltro := strFiltro + 'VLRCON = ' + QuotedStr(edtValor.Text) + ' AND ';

  strFiltro := Trim(strFiltro);
  strFiltro := Copy(strFiltro, 1, Length(strFiltro) -3); //PARA TIRAR O AND DO FINAL

  With frmReimpressaoDocsList.cdsGenDoc Do
  Begin
    If Not fEmptyStr(strFiltro) Then
    Begin
      Filtered := False;
      Filter   := strFiltro;
      Filtered := True;
    End
    Else
    Begin
      Filter   := '';
      Filtered := False;
    End;
  End;

  Close;

end;

end.

