unit untConsultaCadStaDinamicaGeral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB,  
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids,
  EditFocus, Mask, DBCtrls, DBEditFocus,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadStaDinamicaGeral = class(TfrmConsultaComp)
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExecutaTarefaClick(Sender: TObject);
  private
    { Private declarations }
    procedure pDesabilitaColunas;
    procedure pAplicaMascara;
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
  end;

var
  frmConsultaCadStaDinamicaGeral: TfrmConsultaCadStaDinamicaGeral;

implementation

uses untStarmixDinamica, untFuncoesSimples,untIConfTinta, untTintaMaquina;

{$R *.dfm}

procedure TfrmConsultaCadStaDinamicaGeral.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadStaDinamicaGeral.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadStaDinamicaGeral.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadStaDinamicaGeral.pAplicaMascara;
begin
end;

procedure TfrmConsultaCadStaDinamicaGeral.pDesabilitaColunas;
begin
end;

procedure TfrmConsultaCadStaDinamicaGeral.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
  pAplicaMascara;
end;

procedure TfrmConsultaCadStaDinamicaGeral.btnExecutaTarefaClick(
  Sender: TObject);
  Var
    qryConsulta01: TUniQuery;



    strTipEmb: String;
    intQtdEmb: Integer;

    strIteEmb: String;

    strMontad: String;
    strA_n_o_: String;

    strIteSta: String;
    strIteTin: String;

    strTipPre: String;
    
    fltPreEmb: Double;
    fltEmbala: Double;
    fltPreCus: Double;
    fltUnitar: Double;


    stlDesEmb: TStringList;
    stlProEmbLt: TStringList;
    stlProEmbGl: TStringList;
    stlProEmbLa: TStringList;

    strProEmbCo: String;
    strProEmbSp: String;

    fltVolPro: Double;
    dicParams: TDicionario;
    conf: IConfTinta;
begin
  inherited;

  If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
    Exit;

  conf      := fGetConfTinta('STA');

  strIteTin := '';

  strTipEmb := '';
  intQtdEmb := 0;
  fltPreEmb := 0.0;
  fltEmbala := 0.0;

  qryConsulta01 := fCriaQuery(Self);
  qryConsulta01.SQL.Add('SELECT * FROM STA_CADSTA WHERE AUTOINCREM = :AUTINC');
  qryConsulta01.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
  qryConsulta01.Open;

  strIteTin := qryConsulta01.FieldByName('STA_CODSEQ').AsString;
  strMontad := qryConsulta01.FieldByName('STA_MONTAD').AsString;
  strA_n_o_ := qryConsulta01.FieldByName('STA_ANOCOR').AsString;
  strIteSta := conf.fGet('PROSTA'); //fArqIniTinta(0, 'STARMIX', 'PROSTA', '');

  stlDesEmb   := TStringList.Create;
  stlProEmbLt := TStringList.Create;
  stlProEmbGl := TStringList.Create;
  stlProEmbLa := TStringList.Create;

  stlDesEmb.Add('NORMAL');
  stlProEmbLt.Add(conf.fGet('STAIEM')); //stlProEmbLt.Add(fArqIniTinta(0, 'STARMIX', 'STAIEM', ''));
  stlProEmbGl.Add(conf.fGet('STAIGL')); //stlProEmbGl.Add(fArqIniTinta(0, 'STARMIX', 'STAIGL', ''));
  stlProEmbLa.Add(conf.fGet('STAILA')); //stlProEmbLa.Add(fArqIniTinta(0, 'STARMIX', 'STAIGL', ''));

  strProEmbCo := conf.fGet('STAICO'); //fArqIniTinta(0, 'STARMIX', 'STAICO', '');
  strProEmbSp := conf.fGet('STAISP'); //fArqIniTinta(0, 'STARMIX', 'STAISP', '');

  dicParams := TDicionario.Create;
  dicParams['idepro'] := 'STA';

  If (Not fDigDadosTintometricos(qryConsulta01, stlDesEmb, stlProEmbLt, 
        stlProEmbGl, stlProEmbLa, strProEmbCo, strProEmbSp,
        strIteEmb, strTipEmb, strTipPre,
        intQtdEmb, fltPreEmb, fltEmbala, fltPreCus, fltUnitar, fltVolPro, '1', dicParams)) Then
  Begin
    Exit;
  End;

  FreeAndNil(dicParams);
  FreeAndNil(qryConsulta01);
end;

end.
