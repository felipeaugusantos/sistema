unit untDigDadosTintometricosIndustrialMazaIndustrial;

interface

uses
  untDigDadosTintometricosIndustrial, untIDataSet, untAbstractDigTintaIndustrial,
  Classes, Controls, SysUtils;

type
  TDigDadosTintometricosIndustrialMazaIndustrial = class(TDigDadosTintometricosIndustrial)
  private

  public
    class function fPreencheProdutoEmbagemVendaMazaIndustrial(frmDigTinta: TfrmAbstractDigTintaIndustrial; Const intIndEmb: integer; const dtsCadTin: IDataSet): Boolean;
  end;

implementation

uses untAutcomTintaFactory, untIConfTinta;

{ TDigDadosTintometricosIndustrialMazaIndustrial }

class function TDigDadosTintometricosIndustrialMazaIndustrial.fPreencheProdutoEmbagemVendaMazaIndustrial(
  frmDigTinta: TfrmAbstractDigTintaIndustrial; const intIndEmb: integer;
  const dtsCadTin: IDataSet): Boolean;

  function fValidaVolumeFormulucao(
    strTipPre: String; fltVolCon, fltVolDil: Double): Boolean;
  begin
    Result := True;

    If strTipPre = 'C' Then // Concentrado
    Begin
      If fltVolCon = 0 Then
      Begin
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','O Volume do concentrado está zerado!' + #13#10 +
                            'Não será possível vender concentrado,pois a ' + #13#10 +
                            'fórmula está cadastrada somente com volume diluído!',['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin //Diluido
      If fltVolDil = 0 Then
      Begin
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','O Volume do diluído está zerado!' + #13#10 +
                            'Não será possível vender diluído,pois a ' + #13#10 +
                            'fórmula está cadastrada somente com volume concentrado!',['&Ok']);
        Result := False;
      End;
    End;
  end;

Var
  stlDesEmb  : TStringList;
  stlProEmbLt: TStringList;
  stlProEmbGl: TStringList;
  stlProEmbLa: TStringList;
  strProEmbCo: String;
  strProEmbSp: String;
  conf: IConfTinta;
begin
  Try
    conf := TAutcomTintaFactory.Get.fGetConfTinta('MZD');

    stlDesEmb   := TStringList.Create;
    stlProEmbLt := TStringList.Create;
    stlProEmbGl := TStringList.Create;
    stlProEmbLa := TStringList.Create;

    stlDesEmb.Add('MZDZURIL');
    stlDesEmb.Add('MZDZULAC');
    stlDesEmb.Add('MZDZUDUR');
    stlDesEmb.Add('P. U.');
    stlDesEmb.Add('MZDZUCRIL');
    stlDesEmb.Add('FLEET COLOR');
    stlDesEmb.Add('ULTRABASE');
    stlDesEmb.Add('MZDZUDUR PU MS');
    stlDesEmb.Add('SHERTRUCKMZD');

    stlProEmbLt.Add(conf.fGet('MZDIEM'));
    stlProEmbLt.Add(conf.fGet('MZDLLA'));
    stlProEmbLt.Add(conf.fGet('MZDLPO'));
    stlProEmbLt.Add(conf.fGet('MZDLPU'));
    stlProEmbLt.Add(conf.fGet('MZDLCR'));
    stlProEmbLt.Add(conf.fGet('MZDLFL'));
    stlProEmbLt.Add(conf.fGet('ULTRABASELT'));
    stlProEmbLt.Add(conf.fGet('PUMSLT'));
    stlProEmbLt.Add(conf.fGet('SHERLT'));

    stlProEmbGl.Add(conf.fGet('MZDIGL'));
    stlProEmbGl.Add(conf.fGet('MZDGLA'));
    stlProEmbGl.Add(conf.fGet('MZDGPO'));
    stlProEmbGl.Add(conf.fGet('MZDGPU'));
    stlProEmbGl.Add(conf.fGet('MZDGCR'));
    stlProEmbGl.Add(conf.fGet('MZDGFL'));
    stlProEmbGl.Add(conf.fGet('ULTRABASEGL'));
    stlProEmbGl.Add(conf.fGet('PUMSGL'));
    stlProEmbGl.Add(conf.fGet('SHERGL'));

    stlProEmbLa.Add(conf.fGet('MZDILA'));
    stlProEmbLa.Add(conf.fGet('MZDMZD'));
    stlProEmbLa.Add(conf.fGet('MZDLDU'));
    stlProEmbLa.Add(conf.fGet('MZDLAP'));
    stlProEmbLa.Add(conf.fGet('MZDLIL'));
    stlProEmbLa.Add(conf.fGet('MZDLCO'));
    stlProEmbLa.Add(conf.fGet('ULTRABASELA'));
    stlProEmbLa.Add(conf.fGet('PUMSLA'));
    stlProEmbLa.Add(conf.fGet('SHERLA'));

    strProEmbCo := conf.fGet('MZDCOP');
    strProEmbSp := conf.fGet('MZDSPR');

    frmDigTinta.stlDesEmb   := stlDesEmb;
    frmDigTinta.stlProEmbLt := stlProEmbLt;
    frmDigTinta.stlProEmbGl := stlProEmbGl;
    frmDigTinta.stlProEmbLa := stlProEmbLa;
    frmDigTinta.strProEmbCo := strProEmbCo;
    frmDigTinta.strProEmbSp := strProEmbSp;

    frmDigTinta.chkComCat.Visible := False;

    // Volume minímo permitido (C - Concentrado, D - Diluído).
    frmDigTinta.fltMZDVolMiC := dtsCadTin.FieldByName('MZD_VOLMIC').AsFloat;
    frmDigTinta.fltMZDVolMiD := dtsCadTin.FieldByName('MZD_VOLMID').AsFloat;

    frmDigTinta.fltVolumePadraoSpray := 0.100;

    frmDigTinta.intIndEmb            := intIndEmb;

    Result := (frmDigTinta.ShowModal = mrOk)
      And fValidaVolumeFormulucao(TAutcomTintaFactory.Get.IIF(frmDigTinta.rdgModoVenda.ItemIndex = 0, 'C', 'D'),
                                       dtsCadTin.FieldByName('MZD_VOLCON').AsFloat,
                                       dtsCadTin.FieldByName('MZD_VOLDIL').AsFloat);
  Finally
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlProEmbLa) then FreeAndNil(stlProEmbLa);
  End;
end;

end.
