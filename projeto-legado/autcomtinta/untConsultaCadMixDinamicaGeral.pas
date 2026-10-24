unit untConsultaCadMixDinamicaGeral;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untConsultaComp, DB, 
   Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, EditFocus, Mask, DBCtrls, DBEditFocus, untIConfTinta, unttintamaquina,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadMixDinamicaGeral = class(TfrmConsultaComp)
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExecutaTarefaClick(Sender: TObject);
  private
    { Private declarations }
    procedure pDesabilitaColunas;
    procedure pAplicaMascara;
    procedure pCalculaDados;

    procedure pAtualizaDados(Data: TDataSet);
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
  end;

var
  frmConsultaCadMixDinamicaGeral: TfrmConsultaCadMixDinamicaGeral;

implementation

uses untConsulta, untFuncoes, untFuncoesSimples, untLazzumixDinamica;

{$R *.dfm}

procedure TfrmConsultaCadMixDinamicaGeral.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadMixDinamicaGeral.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
  pCalculaDados;
end;

procedure TfrmConsultaCadMixDinamicaGeral.pDesabilitaColunas;
begin
  pAplicaMascara;
end;

procedure TfrmConsultaCadMixDinamicaGeral.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
  pAplicaMascara;
  pCalculaDados;
end;

procedure TfrmConsultaCadMixDinamicaGeral.pAplicaMascara;
begin
  //
end;

procedure TfrmConsultaCadMixDinamicaGeral.pAtualizaDados(Data: TDataSet);
begin
  pAplicaMascara;
  pCalculaDados;
end;

procedure TfrmConsultaCadMixDinamicaGeral.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta.AfterScroll := pAtualizaDados;
end;

procedure TfrmConsultaCadMixDinamicaGeral.pCalculaDados;
begin
  //
end;

procedure TfrmConsultaCadMixDinamicaGeral.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadMixDinamicaGeral.btnExecutaTarefaClick(
  Sender: TObject);
  Var
    qryConsulta01: TUniQuery;
    {*******************************************}
    {* PARAMETROS                              *}
    {****************************************MV*}



    strTipPre: String;

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

    stlDesEmb: TStringList;

    stlProEmbLt: TStringList;

    stlProEmbGl: TStringList;

    stlProEmbLa: TStringList;

    strProEmbCo: String;

    strProEmbSp: String;

    fltVolPro: Double;
    conf: IConfTinta;
begin
  inherited;

  stlDesEmb     := TStringList.Create;
  stlProEmbLt   := TStringList.Create;
  stlProEmbGl   := TStringList.Create;
  stlProEmbLa   := TStringList.Create;
  qryConsulta01 := fCriaQuery(Self);

  If (Not qryConsulta.Active) Or (qryConsulta.IsEmpty) Then
    Exit;

  conf := fGetConfTinta('LAZ');


  try
    strIteTin := '';
    fltPreCus := 0.0;
    fltUnitar := 0.0;

    strTipPre := '';
    strTipEmb := '';
    intQtdEmb := 0;
    fltPreEmb := 0.0;
    fltEmbala := 0.0;

    qryConsulta01.SQL.Add('SELECT * FROM LAZ_CADMIX WHERE AUTOINCREM = :AUTINC');
    qryConsulta01.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
    qryConsulta01.Open;

    strIteTin := qryConsulta01.FieldByName('MIX_CODIGO').AsString;
    strMontad := qryConsulta01.FieldByName('MIX_MONTAD').AsString;
    strA_n_o_ := qryConsulta01.FieldByName('MIX_A_N_O_').AsString;

    stlDesEmb.Add('LAZZURIL');
    stlDesEmb.Add('LAZZULAC');
    stlDesEmb.Add('LAZZUDUR');
    stlDesEmb.Add('P. U.');
    stlDesEmb.Add('LAZZUCRIL');
    stlDesEmb.Add('FLEET COLOR');
    stlDesEmb.Add('ULTRABASE');
    stlDesEmb.Add('LAZZUDUR PU MS');

    stlProEmbLt.Add(conf.fGet('LAZIEM')); //stlProEmbLt.Add(fArqIniTinta(0, 'LAZZUMIX', 'LAZIEM', ''));
    stlProEmbLt.Add(conf.fGet('LAZLLA')); //stlProEmbLt.Add(fArqIniTinta(0, 'LAZZUMIX', 'LAZLLA', ''));
    stlProEmbLt.Add(conf.fGet('LAZLPO')); //stlProEmbLt.Add(fArqIniTinta(0, 'LAZZUMIX', 'LAZLPO', ''));
    stlProEmbLt.Add(conf.fGet('LAZLPU')); //stlProEmbLt.Add(fArqIniTinta(0, 'LAZZUMIX', 'LAZLPU', ''));
    stlProEmbLt.Add(conf.fGet('LAZLCR')); //stlProEmbLt.Add(fArqIniTinta(0, 'LAZZUMIX', 'LAZLCR', ''));
    stlProEmbLt.Add(conf.fGet('LAZLFL')); //stlProEmbLt.Add(fArqIniTinta(0, 'LAZZUMIX', 'LAZLFL', ''));
    stlProEmbLt.Add(conf.fGet('ULTRABASELT')); //stlProEmbLt.Add(fArqIniTinta(0, 'LAZZUMIX', 'ULTRABASELT', ''));
    stlProEmbLt.Add(conf.fGet('PUMSLT')); //stlProEmbLt.Add(fArqIniTinta(0, 'LAZZUMIX', 'PUMSLT', ''));

    stlProEmbGl.Add(conf.fGet('LAZIGL')); //stlProEmbGl.Add(fArqIniTinta(0, 'LAZZUMIX', 'LAZIGL', ''));
    stlProEmbGl.Add(conf.fGet('LAZGLA')); //stlProEmbGl.Add(fArqIniTinta(0, 'LAZZUMIX', 'LAZGLA', ''));
    stlProEmbGl.Add(conf.fGet('LAZGPO')); //stlProEmbGl.Add(fArqIniTinta(0, 'LAZZUMIX', 'LAZGPO', ''));
    stlProEmbGl.Add(conf.fGet('LAZGPU')); //stlProEmbGl.Add(fArqIniTinta(0, 'LAZZUMIX', 'LAZGPU', ''));
    stlProEmbGl.Add(conf.fGet('LAZGCR')); //stlProEmbGl.Add(fArqIniTinta(0, 'LAZZUMIX', 'LAZGCR', ''));
    stlProEmbGl.Add(conf.fGet('LAZGFL')); //stlProEmbGl.Add(fArqIniTinta(0, 'LAZZUMIX', 'LAZGFL', ''));
    stlProEmbGl.Add(conf.fGet('ULTRABASEGL')); //stlProEmbGl.Add(fArqIniTinta(0, 'LAZZUMIX', 'ULTRABASEGL', ''));
    stlProEmbGl.Add(conf.fGet('PUMSGL')); //stlProEmbGl.Add(fArqIniTinta(0, 'LAZZUMIX', 'PUMSGL', ''));

    stlProEmbLa.Add(conf.fGet('LAZILA'));
    stlProEmbLa.Add(conf.fGet('LAZLAZ'));
    stlProEmbLa.Add(conf.fGet('LAZLDU'));
    stlProEmbLa.Add(conf.fGet('LAZLAP'));
    stlProEmbLa.Add(conf.fGet('LAZLIL'));
    stlProEmbLa.Add(conf.fGet('LAZLCO'));
    stlProEmbLa.Add(conf.fGet('ULTRABASELA'));
    stlProEmbLa.Add(conf.fGet('PUMSLA'));
    stlProEmbLa.Add(conf.fGet('SHERLA'));

    strProEmbCo := conf.fGet('LAZCOP'); //fArqIniTinta(0, 'LAZZUMIX', 'LAZCOP', '');

    strProEmbSp := conf.fGet('LAZSPR'); //fArqIniTinta(0, 'LAZZUMIX', 'LAZSPR', '');

    If (Not fDigDadosTintometricos(qryConsulta01, stlDesEmb, stlProEmbLt,
      stlProEmbGl, stlProEmbLa, strProEmbCo, strProEmbSp,
      strIteEmb, strTipEmb, strTipPre, intQtdEmb,
      fltPreEmb, fltEmbala, fltPreCus, fltUnitar, fltVolPro, '1', TDicionario.Create)) Then
    Begin
      Exit;
    End;
  finally
    FreeAndNil(qryConsulta01);
    FreeAndNil(stlDesEmb);
    FreeAndNil(stlProEmbLt);
    FreeAndNil(stlProEmbGl);
    FreeAndNil(stlProEmbLa);
  end;
end;
end.
