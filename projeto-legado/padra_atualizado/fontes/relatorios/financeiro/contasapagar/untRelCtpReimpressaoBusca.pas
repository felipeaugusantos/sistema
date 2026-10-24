unit untRelCtpReimpressaoBusca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, MaskEditFocus, StdCtrls, EditFocus, AppEvnts, Menus,
  Buttons, ExtCtrls, Uni, DB, BitBtnLockedIncrem, untTypesSistema,
  frxClass, frxExportCSVTestabilidade, untIFuncoes, untFuncoesSimples,
  untConsultas, UniClientDataSet;

type
  TfrmRelCtpReimpressaoBusca = class(TfrmPai)
    pnlFundo: TPanel;
    Label1: TLabel;
    lblDesDtaIni: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    edtNumDoc: TEditFocus;
    mskDtaIni: TMaskEditFocus;
    edtCodFor: TEditFocus;
    edtDesFor: TEditFocus;
    btnFiltrar: TBitBtnLocked;
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaFornecedor(Var qryCadFor: TUniQuery);
    procedure btnFiltrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    arrFor : TConsultasArray;
  public
    { Public declarations }
    cdsGenCtp : TUniClientDataSet;
  end;


implementation

{$R *.dfm}

procedure TfrmRelCtpReimpressaoBusca.btnFiltrarClick(Sender: TObject);
  Var
    strFilter: String;
begin
  inherited;

  With cdsGenCtp Do
  Begin
    DisableControls;

    strFilter := '';

    If Not fEmptyStr(edtNumDoc.Text) Then
    Begin

      strFilter := strFilter + 'CTP_NUMDUP = ' + QuotedStr(edtNumDoc.Text);

    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin

      If Not fEmptyStr(strFilter) Then
        strFilter := strFilter + ' AND ';

      strFilter := strFilter + 'CTP_DTACAD = ' + QuotedStr(FormatDateTime('YYYY-MM-DD', StrToDate(mskDtaIni.Text)));
    End;

    If Not fEmptyStr(edtCodFor.Text) Then
    Begin

      If Not fEmptyStr(strFilter) Then
        strFilter := strFilter + ' AND ';

      strFilter := strFilter + 'CTP_CODFOR = ' + QuotedStr(edtCodFor.Text);

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

procedure TfrmRelCtpReimpressaoBusca.edtCodForExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodFor.Text) Then
    edtDesFor.Text := 'TODOS'
  Else
    edtDesFor.Text := fRetNomFornecedor(edtCodFor.Text);

  If fEmptyStr(edtDesFor.Text) And (Not fEmptyStr(edtCodFor.Text))  Then
  Begin
    fMensagem('AVISO','Código do fornecedor não encontrado.', ['&O K']);
    edtCodFor.Clear;
    pSetFocus(edtCodFor);
  End;

end;

procedure TfrmRelCtpReimpressaoBusca.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fEntraCons(Key) Then
  Begin

    If fPesqFornecedor(conForSimples, Self, edtCodFor, edtDesFor, Nil, Key, arrFor) Then
      Self.SelectNext(ActiveControl, True, True);

  End;

end;

procedure TfrmRelCtpReimpressaoBusca.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumDoc);
  edtNumDoc.MaxLength := fTamDocCadRec;
  edtNumDoc.TamCampo  := edtNumDoc.MaxLength;
end;

procedure TfrmRelCtpReimpressaoBusca.pCarregaFornecedor(var qryCadFor: TUniQuery);
begin
  If Not (fEmptyStr(edtCodFor.Text)) Then
    edtDesFor.Text := qryCadFor.FieldByName('FOR_NOMFOR').AsString
  Else
    edtDesFor.Text := '';
end;

end.
