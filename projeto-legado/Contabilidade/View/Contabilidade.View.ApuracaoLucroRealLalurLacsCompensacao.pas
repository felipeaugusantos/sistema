unit Contabilidade.View.ApuracaoLucroRealLalurLacsCompensacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiConfirmaContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxLabel, cxCurrencyEdit,
  CurrencyEditFocus, cxGroupBox, Contabilidade.Interfaces, Data.DB, MemDS,
  DBAccess, Uni;

type
  TfrmApuracaoLucroRealLalurLacsCompensacao = class(TfrmPaiConfirmaContabilidade)
    cxLabel1: TcxLabel;
    edtDataInicio: TcxDateEdit;
    edtDataFin: TcxDateEdit;
    lbBCAntesCompesacao: TcxLabel;
    edtBCAntesCompesacao: TCurrencyEditFocus;
    cxLabel2: TcxLabel;
    edtPercentualMaximoCompensacao: TCurrencyEditFocus;
    cxLabel3: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    lbOperacionalAnteriores: TcxLabel;
    lbNaoOperacionalAnteriores: TcxLabel;
    edtOperacionalAnteriores: TCurrencyEditFocus;
    edtNaoOperacionalAnteriores: TCurrencyEditFocus;
    cxLabel6: TcxLabel;
    edtOperacionalPeriodo: TCurrencyEditFocus;
    chbGerarLancamentoParteB: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FStrCodigoApuracao: string ;
    FllTipo: TLacsLalur ;
    FdtaVigenciaInicial: TDateTime ;
    FdtaVigenciaFinal: TDateTime ;
    FfltBaseCalculoAntesCompensacao: double ;
    FqryApucre: TUniQuery ;
    FstrAutoIncCompensacao: string ;
    FstrCodEmp: String ;
    function fValidaPercentualMaximoCompensacao(const AfltValor: double): Boolean ;
  private
     const
       PERMAXCOMPENSACAO = 30.00 ;
       PERMINCOMPENSACAO = 0.00 ;
  public
    { Public declarations }
    property CodigoApuracao: string read FStrCodigoApuracao write FStrCodigoApuracao ;
    property Tipo: TLacsLalur read FllTipo write FllTipo ;
    property VigenciaInicial: TDateTime read FdtaVigenciaInicial write FdtaVigenciaInicial ;
    property VigenciaFinal: TDateTime read FdtaVigenciaFinal write FdtaVigenciaFinal ;
    property BaseCalculoAntesCompensacao: Double read FfltBaseCalculoAntesCompensacao write FfltBaseCalculoAntesCompensacao ;
    property AutoIncCompensacao: String read FstrAutoIncCompensacao ;
    property CodEmp: String read FstrCodEmp write FstrCodEmp ;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoesSimples, Contabilidade.Classes.ApuracaoLucroRealLalurLacs ;

{$R *.dfm}

procedure TfrmApuracaoLucroRealLalurLacsCompensacao.FormCreate(Sender: TObject);
begin
  inherited;
  FqryApucre := fCriaQuery ;
end;

procedure TfrmApuracaoLucroRealLalurLacsCompensacao.FormDestroy(
  Sender: TObject);
begin
  inherited;
  FreeAndNil(FqryApucre) ;
end;

procedure TfrmApuracaoLucroRealLalurLacsCompensacao.FormShow(Sender: TObject);
var
  LfltOperacionalOuBaseNegativa, LfltNaoOperacional: double ;
begin
  inherited;
  edtDataInicio.Date := FdtaVigenciaInicial ;
  edtDataFin.Date := FdtaVigenciaFinal ;
  edtBCAntesCompesacao.Value := FfltBaseCalculoAntesCompensacao ;

  pCarregaCompensacao(FqryApucre, FStrCodigoApuracao) ;

  FstrAutoIncCompensacao := FqryApucre.FieldByName('AUTOINCREM').AsString ;

  if not FqryApucre.IsEmpty then
  begin
    edtPercentualMaximoCompensacao.Value := FqryApucre.FieldByName('CRE_PERMAX').AsFloat ;
    chbGerarLancamentoParteB.Checked := iif(FqryApucre.FieldByName('CRE_LANCAR').AsString = '1', True, False) ;
  end
  else
  begin
    edtPercentualMaximoCompensacao.Value := PERMAXCOMPENSACAO ;
  end ;
  pRetornaSaldoCompesacao(FdtaVigenciaInicial, FllTipo, LfltOperacionalOuBaseNegativa, LfltNaoOperacional, FstrCodEmp) ;
  edtOperacionalAnteriores.Value := LfltOperacionalOuBaseNegativa ;
  edtNaoOperacionalAnteriores.Value := LfltNaoOperacional ;

  if FllTipo = llLacs then
  begin
    lbNaoOperacionalAnteriores.Visible := False ;
    edtNaoOperacionalAnteriores.Visible := False ;
  end;

end;

function TfrmApuracaoLucroRealLalurLacsCompensacao.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtPercentualMaximoCompensacao) Then
    Begin
      if not fValidaPercentualMaximoCompensacao(edtPercentualMaximoCompensacao.Value) then
      Begin
        fMensagem('ATENÇÃO!', 'Percentual máximo de compensação deve ser de '+ formatfloat('#,##0.00', PERMINCOMPENSACAO) +'% a '+ formatfloat('#,##0.00', PERMAXCOMPENSACAO) +'%!', ['&Ok']);
        Result := False;
      End;
    end;
  end;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmApuracaoLucroRealLalurLacsCompensacao.fValidaPercentualMaximoCompensacao(
  const AfltValor: double): Boolean;
begin
  result := False ;
  if AfltValor < PERMINCOMPENSACAO then
    exit ;
  if AfltValor > PERMAXCOMPENSACAO then
    exit ;
  result := True ;
end;

end.
