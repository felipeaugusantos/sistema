unit untConsultaCadWanProGeral;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, Mask, DBCtrls, DBEditFocus, DB,
  Uni, ExtCtrls, StdCtrls,
  ComCtrls, Buttons, Grids, DBGridCitel, DBGrids,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadWanProGeral = class(TfrmConsultaComp)
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
  frmConsultaCadWanProGeral: TfrmConsultaCadWanProGeral;

implementation

uses untFuncoesSimples, untWandaPro, untConsulta,untIConfTinta, untTintaMaquina;

{$R *.dfm}

procedure TfrmConsultaCadWanProGeral.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadWanProGeral.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadWanProGeral.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadWanProGeral.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaCadWanProGeral.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('AUTOINCREM').Visible := False;
end;

procedure TfrmConsultaCadWanProGeral.btnExecutaTarefaClick(
  Sender: TObject);
  Var
    qryConsulta01: TUniQuery;
    stlDesEmb: TStringList;
    stlProEmbLt: TStringList;
    stlProEmbGl: TStringList;
    stlProEmbLa: TStringList;

    strProEmbCo: String;
    strProEmbSp: String;

    strIteEmb: String;
    strTipEmb: String;
    strTipPre: String;
    intQtdEmb: Integer;
    fltPreEmb: Double;
    fltEmbala: Double;
    fltPreCus: Double;
    fltUnitar: Double;
    fltVolPro: Double;
    strCatalize: String;

    strProEmbSs: String;
    conf: IConfTinta;
begin
  inherited;
  If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
    Exit;

  conf := fGetConfTinta('WCP');

  qryConsulta01 := fCriaQuery(Self);
  qryConsulta01.SQL.Add('SELECT * FROM WANPRO_CADWAN WHERE AUTOINCREM = :AUTINC');
  qryConsulta01.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
  qryConsulta01.Open;

  stlDesEmb   := TStringList.Create;
  stlProEmbLt := TStringList.Create;
  stlProEmbGl := TStringList.Create;
  stlProEmbLa := TStringList.Create;

  stlDesEmb.Add('NORMAL');

  stlProEmbLt.Add(conf.fGet('WANIEM')); //stlProEmbLt.Add(fArqIniTinta(0, 'COLOR PRO', 'WANIEM', ''));
  stlProEmbGl.Add(conf.fGet('WANIGL')); //stlProEmbGl.Add(fArqIniTinta(0, 'COLOR PRO', 'WANIGL', ''));
  stlProEmbLa.Add(conf.fGet('WANILA'));

  strProEmbCo := conf.fGet('WANICO'); //fArqIniTinta(0, 'COLOR PRO', 'WANICO', '');
  strProEmbSp := conf.fGet('WANISP'); //fArqIniTinta(0, 'COLOR PRO', 'WANISP', '');
  strProEmbSs := conf.fGet('WANISS'); //fArqIniTinta(0, 'COLOR PRO', 'WANISS', '');

  fDigDadosTintometricos(qryConsulta01, stlDesEmb, stlProEmbLt, 
    stlProEmbGl, stlProEmbLa, strProEmbCo, strProEmbSp,
    strIteEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb, fltEmbala,
    fltPreCus, fltUnitar, fltVolPro, strCatalize, '1', TDicionario.Create,  strProEmbSs);

  FreeAndNil(stlDesEmb);
  FreeAndNil(stlProEmbLt);
  FreeAndNil(stlProEmbGl);
  FreeAndNil(stlProEmbLa);
end;

end.
