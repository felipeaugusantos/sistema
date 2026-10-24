unit untAgrupDuplicatasCtpBusca;

interface

uses
  Classes, Controls, Forms, StdCtrls, untPaiSimples, EditFocus, ComCtrls, Buttons,
  ExtCtrls, Menus, AppEvnts, BitBtnLockedIncrem, cxGraphics, cxControls, System.SysUtils,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore,
  cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmAgrupDuplicatasCtpBusca = class(TfrmPaiSimples)
    edtNumDup: TEditFocus;
    Label1: TLabel;
    pnlFundo: TPanel;
    Label2: TLabel;
    mskDtaVcto: TcxDateEdit;
    Label3: TLabel;
    edtValor: TEditFocus;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edtValorExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    blnConfirma: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strValorFiltro: String;
    strCampoFiltro: String;
  end;


implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmBaixaCtpBusca }

function TfrmAgrupDuplicatasCtpBusca.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumDup) Then
    Begin


    End
    else
    If (Sender = mskDtaVcto) Then
    begin


    end
    else
    If (Sender = edtValor) Then
    begin
      If Not fEmptyStr(edtNumDup.Text) Then
      Begin
        strCampoFiltro := 'CTP_NUMDUP';
        strValorFiltro := edtNumDup.Text;
      End
      else
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaVcto.Text))  Then
      Begin
        strCampoFiltro := 'CTP_DTAVEN';
        strValorFiltro := FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaVcto.Text));
      End
      else
      If Not fEmptyStr(edtValor.Text) Then
      Begin
        strCampoFiltro := 'CTP_VALDUP';
        strValorFiltro := edtValor.Text;
      End
      else
      begin
        strValorFiltro := '';
        strCampoFiltro := '';
      end;

      blnConfirma := True;
      Close;

    End;

  End;
end;

procedure TfrmAgrupDuplicatasCtpBusca.edtValorExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(edtValor.Text) Then
    edtValor.Text := FormatFloat('#,##0.00', fStrToFloat(edtValor.Text));
end;

procedure TfrmAgrupDuplicatasCtpBusca.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Not blnConfirma Then
  Begin
    strValorFiltro := '';
    strCampoFiltro := '';
  End;
end;

procedure TfrmAgrupDuplicatasCtpBusca.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmAgrupDuplicatasCtpBusca.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumDup);
end;

end.

