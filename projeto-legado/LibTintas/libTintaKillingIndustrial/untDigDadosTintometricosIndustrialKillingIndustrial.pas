unit untDigDadosTintometricosIndustrialKillingIndustrial;

interface

uses
  untDigDadosTintometricosIndustrial, untIDataSet, untAbstractDigTintaIndustrial,
  Classes, Controls, SysUtils;

type
  TDigDadosTintometricosIndustrialKillingIndustrial = class(TDigDadosTintometricosIndustrial)
  private

  public
    class function fPreencheProdutoEmbagemVendaKillingIndustrial(frmDigTinta: TfrmAbstractDigTintaIndustrial; Const intIndEmb: integer; const dtsCadTin: IDataSet): Boolean;
  end;

implementation

uses untAutcomTintaFactory, untIConfTinta;

{ TDigDadosTintometricosIndustrialKillingIndustrial }

class function TDigDadosTintometricosIndustrialKillingIndustrial.fPreencheProdutoEmbagemVendaKillingIndustrial(
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
    conf := TAutcomTintaFactory.Get.fGetConfTinta('KIN');

    stlDesEmb   := TStringList.Create;
    stlProEmbLt := TStringList.Create;
    stlProEmbGl := TStringList.Create;
    stlProEmbLa := TStringList.Create;

    stlDesEmb.Add('KINZURIL');
    stlDesEmb.Add('KINZULAC');
    stlDesEmb.Add('KINZUDUR');
    stlDesEmb.Add('P. U.');
    stlDesEmb.Add('KINZUCRIL');
    stlDesEmb.Add('FLEET COLOR');
    stlDesEmb.Add('ULTRABASE');
    stlDesEmb.Add('KINZUDUR PU MS');
    stlDesEmb.Add('SHERTRUCKKIN');

    stlProEmbLt.Add(conf.fGet('KINIEM'));
    stlProEmbLt.Add(conf.fGet('KINLLA'));
    stlProEmbLt.Add(conf.fGet('KINLPO'));
    stlProEmbLt.Add(conf.fGet('KINLPU'));
    stlProEmbLt.Add(conf.fGet('KINLCR'));
    stlProEmbLt.Add(conf.fGet('KINLFL'));
    stlProEmbLt.Add(conf.fGet('ULTRABASELT'));
    stlProEmbLt.Add(conf.fGet('PUMSLT'));
    stlProEmbLt.Add(conf.fGet('SHERLT'));

    stlProEmbGl.Add(conf.fGet('KINIGL'));
    stlProEmbGl.Add(conf.fGet('KINGLA'));
    stlProEmbGl.Add(conf.fGet('KINGPO'));
    stlProEmbGl.Add(conf.fGet('KINGPU'));
    stlProEmbGl.Add(conf.fGet('KINGCR'));
    stlProEmbGl.Add(conf.fGet('KINGFL'));
    stlProEmbGl.Add(conf.fGet('ULTRABASEGL'));
    stlProEmbGl.Add(conf.fGet('PUMSGL'));
    stlProEmbGl.Add(conf.fGet('SHERGL'));

    stlProEmbLa.Add(conf.fGet('KINILA'));
    stlProEmbLa.Add(conf.fGet('KINKIN'));
    stlProEmbLa.Add(conf.fGet('KINLDU'));
    stlProEmbLa.Add(conf.fGet('KINLAP'));
    stlProEmbLa.Add(conf.fGet('KINLIL'));
    stlProEmbLa.Add(conf.fGet('KINLCO'));
    stlProEmbLa.Add(conf.fGet('ULTRABASELA'));
    stlProEmbLa.Add(conf.fGet('PUMSLA'));
    stlProEmbLa.Add(conf.fGet('SHERLA'));

    strProEmbCo := conf.fGet('KINCOP');
    strProEmbSp := conf.fGet('KINSPR');

    frmDigTinta.stlDesEmb   := stlDesEmb;
    frmDigTinta.stlProEmbLt := stlProEmbLt;
    frmDigTinta.stlProEmbGl := stlProEmbGl;
    frmDigTinta.stlProEmbLa := stlProEmbLa;
    frmDigTinta.strProEmbCo := strProEmbCo;
    frmDigTinta.strProEmbSp := strProEmbSp;

    frmDigTinta.chkComCat.Visible := False;

    // Volume minímo permitido (C - Concentrado, D - Diluído).
    frmDigTinta.fltKINVolMiC := dtsCadTin.FieldByName('KIN_VOLMIC').AsFloat;
    frmDigTinta.fltKINVolMiD := dtsCadTin.FieldByName('KIN_VOLMID').AsFloat;

    frmDigTinta.fltVolumePadraoSpray := 0.100;

    frmDigTinta.intIndEmb            := intIndEmb;

    Result := (frmDigTinta.ShowModal = mrOk)
      And fValidaVolumeFormulucao(TAutcomTintaFactory.Get.IIF(frmDigTinta.rdgModoVenda.ItemIndex = 0, 'C', 'D'),
                                       dtsCadTin.FieldByName('KIN_VOLCON').AsFloat,
                                       dtsCadTin.FieldByName('KIN_VOLDIL').AsFloat);
  Finally
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlProEmbLa) then FreeAndNil(stlProEmbLa);
  End;
end;

end.
