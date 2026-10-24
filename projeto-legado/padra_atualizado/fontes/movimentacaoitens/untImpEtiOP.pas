unit untImpEtiOP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, EditFocus,
  Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem, uni, Data.DB;

type
  TfrmImpEtiOP = class(TfrmPaiConfirma)
    edtOrdPro: TEditFocus;
    Label3: TLabel;
    edtQtd: TEditFocus;
    Label1: TLabel;
    procedure edtOrdProKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    strOrdPro : String;
    intQtd    :  Integer;
    { Public declarations }
  end;

var
  frmImpEtiOP: TfrmImpEtiOP;

implementation

{$R *.dfm}

uses untConsultas, untTypesSistema, untFuncoesSimples, TypesRel,
  untFuncoesEtiquetas, untConfiguraEtiquetas, untConfiguraEtiquetasFuncoes;

procedure TfrmImpEtiOP.btnConfirmaClick(Sender: TObject);

  function fImprime : Boolean;
  Var
    prmDllEtq: TParamDllEtiquetas;
    strTipEti: String;
  begin
    prmDllEtq := TParamDllEtiquetas.Create;

    strTipEti := fGetTipoImpressaoEtiquetas('ETIORD');
    Case strTipEti[1] of
      'L': prmDllEtq.tpeTipEtq := tpeOrdemProducao;
      'A': prmDllEtq.tpeTipEtq := tpeOrdemProducaoArgox;
      'Z': prmDllEtq.tpeTipEtq := tpeOrdemProducaoZebra;
    end;

    prmDllEtq.strOrdPro := edtOrdPro.Text;
    prmDllEtq.strCodEmp := AnsiString(VS_strCodEmp);
    prmDllEtq.intQtdEti := StrToInt(edtQtd.Text);

    Result := fImprimeEtiqueta(prmDllEtq);
    FreeAndNil(prmDllEtq);
  end;

begin
  inherited;
  If fVerificaCampos Then
  Begin
    if fImprime then
      Close;
  End;
end;

procedure TfrmImpEtiOP.edtOrdProKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;
  if fPesqOrdemProd(conSimples, Self, edtOrdPro, nil, nil, Key, arrSel) then
  Begin
    If fValidaCampos(edtOrdPro) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmImpEtiOP.FormCreate(Sender: TObject);
begin
  inherited;
  strOrdPro := '';
  intQtd    := 1;
  edtOrdPro.MaxLength := fTamDocCadRec;
  edtOrdPro.TamCampo  := edtOrdPro.MaxLength;
end;

procedure TfrmImpEtiOP.FormShow(Sender: TObject);
begin
  inherited;
  if not fEmptyStr(strOrdPro) then
  begin
    edtOrdPro.Enabled := False;
    edtOrdPro.Text    := strOrdPro;

    edtQtd.text := intToStr(intQtd);
    pSetFocus(edtQtd);
  end;


end;

function TfrmImpEtiOP.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  qryOrdPro : TUniQuery;
begin
  Result := True;

  if Sender = edtOrdPro then
  begin

    If fEmptyStr(edtOrdPro.Text) then
    begin
      fMensagem('','O campo ordem de produção deve ser preenchido!', ['&OK']);
      Result := False;
    end
    else
    begin
      qryOrdPro := fCriaQuery(nil);
      try
        qryOrdPro.SQL.Add('SELECT ');
        qryOrdPro.SQL.Add('  PRO_QTDPRO');
        qryOrdPro.SQL.Add('FROM');
        qryOrdPro.SQL.Add('  MOVPRO ');
        qryOrdPro.SQL.Add('WHERE');
        qryOrdPro.SQL.Add('  PRO_CODPRO = :CODPRO');

        qryOrdPro.ParamByName('CODPRO').AsString := edtOrdPro.Text;

        qryOrdPro.Open;

        if qryOrdPro.isEmpty then
        begin
          pMensagemOk('Ordem de produção não encontrada!');
          Result := False;
        end
        else if blnBuscaPorChave and (qryOrdPro.fieldByName('PRO_QTDPRO').AsInteger > 0) then
            edtQtd.Text := IntToStr(qryOrdPro.fieldByName('PRO_QTDPRO').AsInteger);

      finally
        qryOrdPro.Close;
        FreeAndNil(qryOrdPro)
      end;
    end;

  end

  else if Sender = edtQtd then
  begin

    if strToIntDef(edtQtd.text, 0) = 0 then
    begin
      fMensagem('','A quantidade de etiquetas deve ser maior ou igual a 1!',['&OK']);
      Result := False;
    end;

  end;


  if not Result Then
    pSetFocus(Sender);

end;

end.
