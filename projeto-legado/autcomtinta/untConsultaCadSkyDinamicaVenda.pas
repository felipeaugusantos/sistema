unit untConsultaCadSkyDinamicaVenda;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  untConsultaComp, DB,  
  Uni, BitBtnLockedIncrem,  ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids, UniClientDataSet,
  MemDS, DBAccess;

type
  TfrmConsultaCadSkyDinamicaVenda = class(TfrmConsultaComp)
    btnFormulacao: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExecutaTarefaClick(Sender: TObject);
    procedure btnFormulacaoClick(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure pDesabilitaColunas;
    procedure pAplicaMascara;
    procedure pCalculaDados;

    procedure pAtualizaDados(Data: TDataSet);
    { Private declarations }
  public
    procedure pAtuIndice(intIndice: Integer); override;
    { Public declarations }
  end;

var
  frmConsultaCadSkyDinamicaVenda: TfrmConsultaCadSkyDinamicaVenda;

implementation

uses untFuncoes, untFuncoesSimples, untSkyMixAutomotivaDinamica,untIConfTinta,
  untTintaMaquina,untClientDataSetFactory;

{$R *.dfm}

procedure TfrmConsultaCadSkyDinamicaVenda.FormShow(Sender: TObject);
begin
  inherited;
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadSkyDinamicaVenda.btnFormulacaoClick(Sender: TObject);
var
  stlProEmbGl,
  stlGruEmbGl,
  stlProEmbLt,
  stlGruEmbLt,
  stlDesEmb: TStringList;
  strSkyPga: String;
  strSkyPqu: String;

  strProEmbCo,
  strGruEbmCo,
  strProEmbSp,
  strGruEmbSp,
  strIteEmb,
  strGruEmb,
  strTipEmb,
  strTipPre,
  strTabPre: String;
  intQtdEmb: Integer;
  fltPreEmb,
  fltEmbala,
  fltPreCus,
  fltPreVen,
  fltVolPro: Double;
  dicRetorno: TDicionario;

  qryConsulta: TUniQuery;
  conf: IConfTinta;
  cdsGen: TUniClientDataSet;
begin
  inherited;
  qryConsulta := nil;
  dicRetorno := nil;
  Try
    Try
      conf := fGetConfTinta('SKY');
      qryConsulta := fCriaQuery(Self);
      qryConsulta.SQL.Add('SELECT * FROM SKY_CADSKY WHERE AUTOINCREM = :AUTINC');
      qryConsulta.ParamByName('AUTINC').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
      cdsGen := TClientDataSetFactory.GetClientDataSet(qryConsulta);

      dicRetorno := TDicionario.Create;

      stlDesEmb := TStringList.Create;
      stlDesEmb.Add('LACA');
      stlDesEmb.Add('POLIESTER');
      stlDesEmb.Add('PU');
      stlDesEmb.Add('SINTÉTICO');

      stlProEmbGl :=  TStringList.Create;
      stlGruEmbGl :=  TStringList.Create;
      stlProEmbLt :=  TStringList.Create;
      stlGruEmbLt :=  TStringList.Create;

      strSkyPga := conf.fGet('SKYPGA'); //fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA', '');
      strSkyPqu := conf.fGet('SKYPQU'); //fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU', '');

      stlProEmbGl.Add(strSkyPga);
      stlProEmbGl.Add(conf.fGet('SKYPGA_POLIESTER')); //stlProEmbGl.Add(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA_POLIESTER', strSkyPga));
      stlProEmbGl.Add(conf.fGet('SKYPGA_PU'));        //stlProEmbGl.Add(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA_PU', strSkyPga));
      stlProEmbGl.Add(conf.fGet('SKYPGA_SINTETICO')); //stlProEmbGl.Add(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA_SINTETICO', strSkyPga));

      stlGruEmbGl.Add(fRetGrupoItem(strSkyPga));
      stlGruEmbGl.Add(fRetGrupoItem(conf.fGet('SKYPGA_POLIESTER'))); //stlGruEmbGl.Add(fRetGrupoItem(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA_POLIESTER', strSkyPga)));
      stlGruEmbGl.Add(fRetGrupoItem(conf.fGet('SKYPGA_PU')));        //stlGruEmbGl.Add(fRetGrupoItem(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA_PU', strSkyPga)));
      stlGruEmbGl.Add(fRetGrupoItem(conf.fGet('SKYPGA_SINTETICO'))); //stlGruEmbGl.Add(fRetGrupoItem(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPGA_SINTETICO', strSkyPga)));

      stlProEmbLt.Add(strSkyPqu);
      stlProEmbLt.Add(conf.fGet('SKYPQU_POLIESTER')); //stlProEmbLt.Add(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU_POLIESTER', strSkyPqu));
      stlProEmbLt.Add(conf.fGet('SKYPQU_PU'));        //stlProEmbLt.Add(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU_PU', strSkyPqu));
      stlProEmbLt.Add(conf.fGet('SKYPQU_SINTETICO')); //stlProEmbLt.Add(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU_SINTETICO', strSkyPqu));

      stlGruEmbLt.Add(fRetGrupoItem(strSkyPqu));
      stlGruEmbLt.Add(fRetGrupoItem(conf.fGet('SKYPQU_POLIESTER'))); //stlGruEmbLt.Add(fRetGrupoItem(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU_POLIESTER', strSkyPqu)));
      stlGruEmbLt.Add(fRetGrupoItem(conf.fGet('SKYPQU_PU')));        //stlGruEmbLt.Add(fRetGrupoItem(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU_PU', strSkyPqu)));
      stlGruEmbLt.Add(fRetGrupoItem(conf.fGet('SKYPQU_SINTETICO'))); //stlGruEmbLt.Add(fRetGrupoItem(fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPQU_SINTETICO', strSkyPqu)));

      strProEmbCo := conf.fGet('SKYPCP'); //fArqIniTinta(0, 'SkyMix Automotiva', 'SKYPCP', '');
      strGruEbmCo := fRetGrupoItem(strProEmbCo);

      fDigDadosTintometricos(cdsGen, stlDesEmb, stlProEmbLt, stlGruEmbLt, stlProEmbGl, stlGruEmbGl,
                             strProEmbCo, strGruEbmCo, strProEmbSp, strGruEmbSp,
                             strIteEmb, strGruEmb, strTipEmb, strTipPre, intQtdEmb, fltPreEmb, fltEmbala,
                             fltPreCus, fltPreVen, fltVolPro, strTabPre, dicRetorno);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryConsulta) then FreeAndNil(qryConsulta);
    if Assigned(dicRetorno) then FreeAndNil(dicRetorno);
  End;

end;

procedure TfrmConsultaCadSkyDinamicaVenda.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
  pCalculaDados;
end;

procedure TfrmConsultaCadSkyDinamicaVenda.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta.AfterScroll := pAtualizaDados;
end;

procedure TfrmConsultaCadSkyDinamicaVenda.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadSkyDinamicaVenda.pAplicaMascara;
begin

end;

procedure TfrmConsultaCadSkyDinamicaVenda.pAtualizaDados(Data: TDataSet);
begin
  pAplicaMascara;
  pCalculaDados;
end;

procedure TfrmConsultaCadSkyDinamicaVenda.pCalculaDados;
begin

end;

procedure TfrmConsultaCadSkyDinamicaVenda.pDesabilitaColunas;
begin
  pAplicaMascara;
end;

procedure TfrmConsultaCadSkyDinamicaVenda.pAtuIndice(intIndice: Integer);
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

procedure TfrmConsultaCadSkyDinamicaVenda.btnExecutaTarefaClick(
  Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadSkyNovasFormulas', False);
end;

procedure TfrmConsultaCadSkyDinamicaVenda.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F6 Then
    btnFormulacao.Click;
end;

end.

