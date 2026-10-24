unit untDigDadosTintometricosAutomotivaSkyMixAutomotiva;

interface

uses
  untDigDadosTintometricosAutomotiva, untIDataSet, untAbstractDigTintaAutomotiva,
  Classes, Controls, SysUtils;

type
  TDigDadosTintometricosAutomotivaSkyMixAutomotiva = class(TDigDadosTintometricosAutomotiva)
  private

  public
    class function fPreencheProdutoEmbagemVendaSkyMixAutomotiva(frmDigTinta: TfrmAbstractDigTintaAutomotiva; Const intIndEmb: integer; const dtsCadTin: IDataSet): Boolean;
  end;

implementation

uses untAutcomTintaFactory, untIConfTinta;

{ TDigDadosTintometricosAutomotivaSkyMixAutomotiva }

class function TDigDadosTintometricosAutomotivaSkyMixAutomotiva.fPreencheProdutoEmbagemVendaSkyMixAutomotiva(
  frmDigTinta: TfrmAbstractDigTintaAutomotiva; const intIndEmb: integer;
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
    conf := TAutcomTintaFactory.Get.fGetConfTinta('SKY');

    stlDesEmb   := TStringList.Create;
    stlProEmbLt := TStringList.Create;
    stlProEmbGl := TStringList.Create;
    stlProEmbLa := TStringList.Create;

    stlDesEmb.Add('SKYZURIL');
    stlDesEmb.Add('SKYZULAC');
    stlDesEmb.Add('SKYZUDUR');
    stlDesEmb.Add('P. U.');
    stlDesEmb.Add('SKYZUCRIL');
    stlDesEmb.Add('FLEET COLOR');
    stlDesEmb.Add('ULTRABASE');
    stlDesEmb.Add('SKYZUDUR PU MS');
    stlDesEmb.Add('SHERTRUCKSKY');

    stlProEmbLt.Add(conf.fGet('SKYIEM'));
    stlProEmbLt.Add(conf.fGet('SKYLLA'));
    stlProEmbLt.Add(conf.fGet('SKYLPO'));
    stlProEmbLt.Add(conf.fGet('SKYLPU'));
    stlProEmbLt.Add(conf.fGet('SKYLCR'));
    stlProEmbLt.Add(conf.fGet('SKYLFL'));
    stlProEmbLt.Add(conf.fGet('ULTRABASELT'));
    stlProEmbLt.Add(conf.fGet('PUMSLT'));
    stlProEmbLt.Add(conf.fGet('SHERLT'));

    stlProEmbGl.Add(conf.fGet('SKYIGL'));
    stlProEmbGl.Add(conf.fGet('SKYGLA'));
    stlProEmbGl.Add(conf.fGet('SKYGPO'));
    stlProEmbGl.Add(conf.fGet('SKYGPU'));
    stlProEmbGl.Add(conf.fGet('SKYGCR'));
    stlProEmbGl.Add(conf.fGet('SKYGFL'));
    stlProEmbGl.Add(conf.fGet('ULTRABASEGL'));
    stlProEmbGl.Add(conf.fGet('PUMSGL'));
    stlProEmbGl.Add(conf.fGet('SHERGL'));

    stlProEmbLa.Add(conf.fGet('SKYILA'));
    stlProEmbLa.Add(conf.fGet('SKYSKY'));
    stlProEmbLa.Add(conf.fGet('SKYLDU'));
    stlProEmbLa.Add(conf.fGet('SKYLAP'));
    stlProEmbLa.Add(conf.fGet('SKYLIL'));
    stlProEmbLa.Add(conf.fGet('SKYLCO'));
    stlProEmbLa.Add(conf.fGet('ULTRABASELA'));
    stlProEmbLa.Add(conf.fGet('PUMSLA'));
    stlProEmbLa.Add(conf.fGet('SHERLA'));

    strProEmbCo := conf.fGet('SKYCOP');
    strProEmbSp := conf.fGet('SKYSPR');

    frmDigTinta.stlDesEmb   := stlDesEmb;
    frmDigTinta.stlProEmbLt := stlProEmbLt;
    frmDigTinta.stlProEmbGl := stlProEmbGl;
    frmDigTinta.stlProEmbLa := stlProEmbLa;
    frmDigTinta.strProEmbCo := strProEmbCo;
    frmDigTinta.strProEmbSp := strProEmbSp;

    frmDigTinta.chkComCat.Visible := False;

    // Volume minímo permitido (C - Concentrado, D - Diluído).
    frmDigTinta.fltSKYVolMiC := dtsCadTin.FieldByName('SKY_VOLMIC').AsFloat;
    frmDigTinta.fltSKYVolMiD := dtsCadTin.FieldByName('SKY_VOLMID').AsFloat;

    frmDigTinta.fltVolumePadraoSpray := 0.100;

    frmDigTinta.intIndEmb            := intIndEmb;

    Result := (frmDigTinta.ShowModal = mrOk)
      And fValidaVolumeFormulucao(TAutcomTintaFactory.Get.IIF(frmDigTinta.rdgModoVenda.ItemIndex = 0, 'C', 'D'),
                                       dtsCadTin.FieldByName('SKY_VOLCON').AsFloat,
                                       dtsCadTin.FieldByName('SKY_VOLDIL').AsFloat);
  Finally
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlProEmbLa) then FreeAndNil(stlProEmbLa);
  End;
end;

end.
