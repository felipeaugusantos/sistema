unit untConsultaFiltrosCtaReceber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, Mask, MaskEditFocus, EditFocus, untFuncoesSimples, untTypesSistema,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar;

type
  TfrmConsultaFiltrosCtaReceber = class(TfrmPai)
    Panel1: TPanel;
    btnGravar: TBitBtnLocked;
    Label12: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    edtNumDup: TEditFocus;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    rdgStatus: TRadioGroup;
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    arrCliente : TConsultasArray;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }
  end;

var
  frmConsultaFiltrosCtaReceber: TfrmConsultaFiltrosCtaReceber;

implementation

uses untFuncoesConsulta, untConsultas;

{$R *.dfm}

procedure TfrmConsultaFiltrosCtaReceber.btnGravarClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos  Then
     Exit
  else
    ModalResult := mrOk;
end;

procedure TfrmConsultaFiltrosCtaReceber.edtCodClienteExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCliente,edtDesCliente,arrCliente,nil,fRetNomCliente,'do Cliente');
end;

procedure TfrmConsultaFiltrosCtaReceber.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrCliente, True) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConsultaFiltrosCtaReceber.FormActivate(Sender: TObject);
begin
  inherited;
  edtNumDup.TamCampo  := fTamDocCadRec;
  edtNumDup.MaxLength := fTamDocCadRec;
  pSetFocus(edtCodCliente);
end;

procedure TfrmConsultaFiltrosCtaReceber.FormShow(Sender: TObject);
begin
  inherited;
  mskDtaIni.Text := '';
  mskDtaFin.Text := '';
end;

function TfrmConsultaFiltrosCtaReceber.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {*********************}
    {* VALIDA DATAS      *}
    {******************FA*}
    If (Sender = mskDtaIni) or (Sender = mskDtaFin) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
      begin
        fMensagem('ATENÇÃO!', 'A Data Inicial deve ser preenchida!', ['&O k']);
        Result := False;
      end;

      If (Sender = mskDtaFin) and (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
      Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
      End;

      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) and (Not fValidaPeriodo(mskDtaIni.Text,mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO','A Data Final deve ser maior ou igual a Data Inicial!',['&OK']);
        Result := False;
      End;

    End

  End;
end;

end.
