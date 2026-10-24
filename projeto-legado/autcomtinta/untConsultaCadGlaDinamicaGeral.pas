unit untConsultaCadGlaDinamicaGeral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, Mask, DBCtrls, DBEditFocus, DB,
    Uni, ExtCtrls, StdCtrls,
  ComCtrls, Buttons, Grids, DBGridCitel, DBGrids, StrUtils,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadGlaDinamicaGeral = class(TfrmConsultaComp)
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExecutaTarefaClick(Sender: TObject);
  private
    procedure pDesabilitaColunas;
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
  end;

var
  frmConsultaCadGlaDinamicaGeral: TfrmConsultaCadGlaDinamicaGeral;

implementation

uses untGlasuritDinamica, untFuncoesSimples, untIConfTinta, untTintaMaquina;

{$R *.dfm}

procedure TfrmConsultaCadGlaDinamicaGeral.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadGlaDinamicaGeral.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadGlaDinamicaGeral.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadGlaDinamicaGeral.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaCadGlaDinamicaGeral.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('AUTOINCREM').Visible := False;
end;

procedure TfrmConsultaCadGlaDinamicaGeral.btnExecutaTarefaClick(
  Sender: TObject);
  Var
    qryConsulta01: TUniQuery;

    strTipEmb: String;
    intQtdEmb: Integer;
    strIteTin: String;
    fltPreEmb: Double;
    fltEmbala: Double;
    fltPreCus: Double;
    fltUnitar: Double;
    strIteEmb: String;
    strMontad: String;
    strA_n_o_: String;
    strChaFor: String;
    fltVolPro: Double;
    stlDesEmb: TStringList;
    stlProEmbLt: TStringList;
    stlProEmbGl: TStringList;

    strProEmbCo: String;
    strProEmbSp: String;
    strProEmbBa: String;

    strTipPre: String;
    conf: IConfTinta;
begin
  inherited;

  If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
    Exit;

  conf := fGetConfTinta('GLA');

  strIteTin := '';

  strTipEmb := '';
  intQtdEmb := 0;
  fltPreEmb := 0.0;
  fltEmbala := 0.0;

  qryConsulta01 := fCriaQuery(Self);
  qryConsulta01.SQL.Add('SELECT * FROM GLA_CADGLA WHERE AUTOINCREM = :AUTINC');
  qryConsulta01.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
  qryConsulta01.Open;

  stlDesEmb   := TStringList.Create;
  stlProEmbLt := TStringList.Create;
  stlProEmbGl := TStringList.Create;

  stlDesEmb.Add('NORMAL');
  stlProEmbLt.Add(conf.fGet('GLAIEM')); //stlProEmbLt.Add(fArqIniTinta(0, 'GLASURIT', 'GLAIEM', ''));
  stlProEmbGl.Add(conf.fGet('GLAIGL')); //stlProEmbGl.Add(fArqIniTinta(0, 'GLASURIT', 'GLAIGL', ''));

  strProEmbCo := conf.fGet('GLAICO'); //fArqIniTinta(0, 'GLASURIT', 'GLAICO', '');
  strProEmbSp := conf.fGet('GLAISP'); //fArqIniTinta(0, 'GLASURIT', 'GLAISP', '');
  strProEmbBa := conf.fGet('GLABAL');

  strIteTin := qryConsulta01.FieldByName('GLA_LINHA_').AsString +
    qryConsulta01.FieldByName('GLA_MONTAD').AsString + qryConsulta01.FieldByName('GLA_DESCRI').AsString +
    qryConsulta01.FieldByName('GLA_CODPRO').AsString + qryConsulta01.FieldByName('GLA_ANOCOR').AsString +
    qryConsulta01.FieldByName('GLA_VARIAC').AsString + qryConsulta01.FieldByName('GLA_FORM01').AsString +
    AnsiReplaceStr(FormatFloat('0.0', qryConsulta01.FieldByName('GLA_QTDB01').AsFloat), ',', '.') + qryConsulta01.FieldByName('GLA_FORM02').AsString +
    AnsiReplaceStr(FormatFloat('0.0', qryConsulta01.FieldByName('GLA_QTDB02').AsFloat), ',', '.') + qryConsulta01.FieldByName('GLA_FORM03').AsString +
    AnsiReplaceStr(FormatFloat('0.0', qryConsulta01.FieldByName('GLA_QTDB03').AsFloat), ',', '.') + qryConsulta01.FieldByName('GLA_FORM04').AsString +
    AnsiReplaceStr(FormatFloat('0.0', qryConsulta01.FieldByName('GLA_QTDB04').AsFloat), ',', '.') + qryConsulta01.FieldByName('GLA_FORM05').AsString +
    AnsiReplaceStr(FormatFloat('0.0', qryConsulta01.FieldByName('GLA_QTDB05').AsFloat), ',', '.') + qryConsulta01.FieldByName('GLA_FORM06').AsString +
    AnsiReplaceStr(FormatFloat('0.0', qryConsulta01.FieldByName('GLA_QTDB06').AsFloat), ',', '.') + qryConsulta01.FieldByName('GLA_FORM07').AsString +
    AnsiReplaceStr(FormatFloat('0.0', qryConsulta01.FieldByName('GLA_QTDB07').AsFloat), ',', '.') + qryConsulta01.FieldByName('GLA_FORM08').AsString +
    AnsiReplaceStr(FormatFloat('0.0', qryConsulta01.FieldByName('GLA_QTDB08').AsFloat), ',', '.') + qryConsulta01.FieldByName('GLA_FORM09').AsString +
    AnsiReplaceStr(FormatFloat('0.0', qryConsulta01.FieldByName('GLA_QTDB09').AsFloat), ',', '.') + qryConsulta01.FieldByName('GLA_FORM10').AsString +
    AnsiReplaceStr(FormatFloat('0.0', qryConsulta01.FieldByName('GLA_QTDB10').AsFloat), ',', '.') + qryConsulta01.FieldByName('GLA_FORM11').AsString +
    AnsiReplaceStr(FormatFloat('0.0', qryConsulta01.FieldByName('GLA_QTDB11').AsFloat), ',', '.') + qryConsulta01.FieldByName('GLA_FORM12').AsString +
    AnsiReplaceStr(FormatFloat('0.0', qryConsulta01.FieldByName('GLA_QTDB12').AsFloat), ',', '.') + qryConsulta01.FieldByName('GLA_FORM13').AsString +
    AnsiReplaceStr(FormatFloat('0.0', qryConsulta01.FieldByName('GLA_QTDB13').AsFloat), ',', '.') + qryConsulta01.FieldByName('GLA_FORM14').AsString +
    AnsiReplaceStr(FormatFloat('0.0', qryConsulta01.FieldByName('GLA_QTDB14').AsFloat), ',', '.') + qryConsulta01.FieldByName('GLA_FORM15').AsString +
    AnsiReplaceStr(FormatFloat('0.0', qryConsulta01.FieldByName('GLA_QTDB15').AsFloat), ',', '.') + qryConsulta01.FieldByName('GLA_FORM16').AsString +
    AnsiReplaceStr(FormatFloat('0.0', qryConsulta01.FieldByName('GLA_QTDB16').AsFloat), ',', '.') + qryConsulta01.FieldByName('GLA_FORM17').AsString +
    AnsiReplaceStr(FormatFloat('0.0', qryConsulta01.FieldByName('GLA_QTDB17').AsFloat), ',', '.') + qryConsulta01.FieldByName('GLA_FORM18').AsString +
    AnsiReplaceStr(FormatFloat('0.0', qryConsulta01.FieldByName('GLA_QTDB18').AsFloat), ',', '.') + qryConsulta01.FieldByName('GLA_FORM19').AsString +
    AnsiReplaceStr(FormatFloat('0.0', qryConsulta01.FieldByName('GLA_QTDB19').AsFloat), ',', '.') + qryConsulta01.FieldByName('GLA_FORM20').AsString +
    AnsiReplaceStr(FormatFloat('0.0', qryConsulta01.FieldByName('GLA_QTDB20').AsFloat), ',', '.');

  strMontad := qryConsulta01.FieldByName('GLA_MONTAD').AsString;
  strA_n_o_ := qryConsulta01.FieldByName('GLA_ANOCOR').AsString;

  strChaFor := qryConsulta01.FieldByName('GLA_LINHA_').AsString + ' ' +
               qryConsulta01.FieldByName('GLA_DESCRI').AsString + ' ' +
               qryConsulta01.FieldByName('GLA_MONTAD').AsString + ' ' +
               qryConsulta01.FieldByName('GLA_CODPRO').AsString;

  fltPreCus := 0.0;
  fltUnitar := 0.0;

  If (Not fDigDadosTintometricos(qryConsulta01, stlDesEmb, stlProEmbLt,
        stlProEmbGl, strProEmbCo, strProEmbSp, strProEmbBa,
        strTipPre, strIteEmb, strTipEmb, intQtdEmb, fltPreEmb, fltEmbala,
        fltPreCus, fltUnitar, fltVolPro, '1', TDicionario.Create)) Then
  Begin
    Exit;
  End;

  FreeAndNil(qryConsulta01);
end;

end.
