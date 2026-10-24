unit untConsultaCadAutDinamicaGeral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, Mask, DBCtrls, DBEditFocus, DB,
    Uni, ExtCtrls, StdCtrls,
  ComCtrls, Buttons, Grids, DBGridCitel, DBGrids,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadAutDinamicaGeral = class(TfrmConsultaComp)
    Panel2: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    dbeVenLt: TDBEditFocus;
    dbeVenGl: TDBEditFocus;
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
  frmConsultaCadAutDinamicaGeral: TfrmConsultaCadAutDinamicaGeral;

implementation

uses untAutoColorDinamica, untFuncoesSimples,untIConfTinta, untTintaMaquina;

{$R *.dfm}

procedure TfrmConsultaCadAutDinamicaGeral.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
  btnExecutaTarefa.Visible := True;
end;

procedure TfrmConsultaCadAutDinamicaGeral.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadAutDinamicaGeral.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadAutDinamicaGeral.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaCadAutDinamicaGeral.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('AUT_VENLT').Visible := False;
  qryConsulta.FieldByName('AUT_VENGL').Visible := False;
  qryConsulta.FieldByName('AUTOINCREM').Visible := False;

  (qryConsulta.FieldByName('AUT_VENLT') As TFloatField).DisplayFormat := '#,##0.00';
  (qryConsulta.FieldByName('AUT_VENGL') As TFloatField).DisplayFormat := '#,##0.00';
end;

procedure TfrmConsultaCadAutDinamicaGeral.btnExecutaTarefaClick(
  Sender: TObject);
  Var
    qryConsulta01: TUniQuery;
    stlDesEmb   :  TStringList;
    stlProEmbGl :  TStringList;
    stlProEmbLt :  TStringList;

    strProEmbCo : String;
    strProEmbSp : String;
    strProEmbTb : String;
    strProEmbLa : String;

    strIteEmb: String;
    strTipEmb: String;
    strTipPre: String;
    intQtdEmb: Integer;
    fltPreEmb: Double;
    fltEmbala: Double;
    fltPreCus: Double;
    fltPreVen: Double;
    fltVolPro: Double;
    strLinTin: String;
    strCatalize: String;
    strCodDil: String;
    fltPorDil: Double;
    strDilCon: String;
    fltPorCat: Double;
    conf: IConfTinta;
begin
  inherited;
  conf  := fGetConfTinta('AUT');

  stlDesEmb   :=  TStringList.Create;
  stlProEmbGl :=  TStringList.Create;
  stlProEmbLt :=  TStringList.Create;

  stlDesEmb.Add('Normal');
  stlProEmbGl.Add(conf.fGet('AUTIGL')); //stlProEmbGl.Add(fArqIniTinta(0, 'AUTOCOLOR', 'AUTIGL', ''));
  stlProEmbLt.Add(conf.fGet('AUTIEM')); //stlProEmbLt.Add(fArqIniTinta(0, 'AUTOCOLOR', 'AUTIEM', ''));

  strProEmbCo := conf.fGet('AUTICO'); //fArqIniTinta(0, 'AUTOCOLOR', 'AUTICO', '');
  strProEmbSp := conf.fGet('AUTISP'); //fArqIniTinta(0, 'AUTOCOLOR', 'AUTISP', '');

  strProEmbTb := conf.fGet('AUTITB'); //fArqIniTinta(0, 'AUTOCOLOR', 'AUTITB', '');
  strProEmbLa := conf.fGet('AUTILA'); //fArqIniTinta(0, 'AUTOCOLOR', 'AUTILA', '');

  If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
    Exit;

  qryConsulta01 := fCriaQuery(Self);
  qryConsulta01.SQL.Add('SELECT * FROM AUT_CADAUT WHERE AUTOINCREM = :AUTINC');
  qryConsulta01.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
  qryConsulta01.Open;

  If Not fDigDadosTintometricos(qryConsulta01, stlDesEmb, stlProEmbLt, stlProEmbGl, 
                              strProEmbCo, strProEmbSp, strProEmbTb, strProEmbLa,
                              strIteEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb, fltEmbala,
                              fltPreCus, fltPreVen, fltVolPro, strLinTin, strCatalize, strCodDil, fltPorDil,
                              strDilCon, fltPorCat, '1', TDicionario.Create) Then

  FreeAndNil(qryConsulta01);
  FreeAndNil(stlDesEmb);
  FreeAndNil(stlProEmbGl);
  FreeAndNil(stlProEmbLt);
end;

end.
