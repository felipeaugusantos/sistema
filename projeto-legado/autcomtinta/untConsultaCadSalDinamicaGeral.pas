unit untConsultaCadSalDinamicaGeral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, Mask, DBCtrls, DBEditFocus, DB,
    Uni, ExtCtrls, StdCtrls,
  ComCtrls, Buttons, Grids, DBGridCitel, DBGrids,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadSalDinamicaGeral = class(TfrmConsultaComp)
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
  frmConsultaCadSalDinamicaGeral: TfrmConsultaCadSalDinamicaGeral;

implementation

uses untSalcomixDinamica, untFuncoesSimples,untIConfTinta, untTintaMaquina;

{$R *.dfm}

procedure TfrmConsultaCadSalDinamicaGeral.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadSalDinamicaGeral.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadSalDinamicaGeral.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadSalDinamicaGeral.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaCadSalDinamicaGeral.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('AUTOINCREM').Visible := False;
end;

procedure TfrmConsultaCadSalDinamicaGeral.btnExecutaTarefaClick(
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

  conf := fGetConfTinta('SAL');

  strIteTin := '';

  strTipEmb := '';
  intQtdEmb := 0;
  fltPreEmb := 0.0;
  fltEmbala := 0.0;

  qryConsulta01 := fCriaQuery(Self);
  qryConsulta01.SQL.Add('SELECT * FROM SAL_CADSAL WHERE AUTOINCREM = :AUTINC');
  qryConsulta01.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
  qryConsulta01.Open;

  stlDesEmb   := TStringList.Create;
  stlProEmbLt := TStringList.Create;
  stlProEmbGl := TStringList.Create;

  stlDesEmb.Add('NORMAL');
  stlProEmbLt.Add(conf.fGet('SALIEM')); //stlProEmbLt.Add(fArqIniTinta(0, 'SALCOMIX', 'SALIEM', ''));
  stlProEmbGl.Add(conf.fGet('SALIGL')); //stlProEmbGl.Add(fArqIniTinta(0, 'SALCOMIX', 'SALIGL', ''));

  strProEmbCo := conf.fGet('SALICO'); //fArqIniTinta(0, 'SALCOMIX', 'SALICO', '');
  strProEmbSp := conf.fGet('SALISP'); //fArqIniTinta(0, 'SALCOMIX', 'SALISP', '');
  strProEmbBa := conf.fGet('SALIBA');   

  strIteTin := qryConsulta01.FieldByName('SAL_CODSEQ').AsString;
  strMontad := qryConsulta01.FieldByName('SAL_MONTAD').AsString;
  strA_n_o_ := qryConsulta01.FieldByName('SAL_ANOCOR').AsString;

  strChaFor := qryConsulta01.FieldByName('SAL_LINHA_').AsString + ' ' +
               qryConsulta01.FieldByName('SAL_DESCRI').AsString + ' ' +
               qryConsulta01.FieldByName('SAL_MONTAD').AsString + ' ' +
               qryConsulta01.FieldByName('SAL_CODPRO').AsString;

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
