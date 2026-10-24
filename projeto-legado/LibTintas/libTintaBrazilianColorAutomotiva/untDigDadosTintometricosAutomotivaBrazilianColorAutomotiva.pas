unit untDigDadosTintometricosAutomotivaBrazilianColorAutomotiva;

interface

uses
  untDigDadosTintometricosAutomotiva, untIDataSet, untAbstractDigTintaAutomotiva,
  Classes, Controls, SysUtils;

type
  TDigDadosTintometricosAutomotivaBrazilianColorAutomotiva = class(TDigDadosTintometricosAutomotiva)
  private

  public
    class function fPreencheProdutoEmbagemVendaBrazilianColorAutomotiva(frmDigTinta: TfrmAbstractDigTintaAutomotiva; Const intIndEmb: integer; const dtsCadTin: IDataSet): Boolean;
  end;

implementation

uses untAutcomTintaFactory, untIConfTinta;

{ TDigDadosTintometricosAutomotivaBrazilianColorAutomotiva }

class function TDigDadosTintometricosAutomotivaBrazilianColorAutomotiva.fPreencheProdutoEmbagemVendaBrazilianColorAutomotiva(
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
    conf := TAutcomTintaFactory.Get.fGetConfTinta('BZC');

    stlDesEmb   := TStringList.Create;
    stlProEmbLt := TStringList.Create;
    stlProEmbGl := TStringList.Create;
    stlProEmbLa := TStringList.Create;

    stlDesEmb.Add('BZCZURIL');
    stlDesEmb.Add('BZCZULAC');
    stlDesEmb.Add('BZCZUDUR');
    stlDesEmb.Add('P. U.');
    stlDesEmb.Add('BZCZUCRIL');
    stlDesEmb.Add('FLEET COLOR');
    stlDesEmb.Add('ULTRABASE');
    stlDesEmb.Add('BZCZUDUR PU MS');
    stlDesEmb.Add('SHERTRUCKBZC');

    stlProEmbLt.Add(conf.fGet('BZCIEM'));
    stlProEmbLt.Add(conf.fGet('BZCLLA'));
    stlProEmbLt.Add(conf.fGet('BZCLPO'));
    stlProEmbLt.Add(conf.fGet('BZCLPU'));
    stlProEmbLt.Add(conf.fGet('BZCLCR'));
    stlProEmbLt.Add(conf.fGet('BZCLFL'));
    stlProEmbLt.Add(conf.fGet('ULTRABASELT'));
    stlProEmbLt.Add(conf.fGet('PUMSLT'));
    stlProEmbLt.Add(conf.fGet('SHERLT'));

    stlProEmbGl.Add(conf.fGet('BZCIGL'));
    stlProEmbGl.Add(conf.fGet('BZCGLA'));
    stlProEmbGl.Add(conf.fGet('BZCGPO'));
    stlProEmbGl.Add(conf.fGet('BZCGPU'));
    stlProEmbGl.Add(conf.fGet('BZCGCR'));
    stlProEmbGl.Add(conf.fGet('BZCGFL'));
    stlProEmbGl.Add(conf.fGet('ULTRABASEGL'));
    stlProEmbGl.Add(conf.fGet('PUMSGL'));
    stlProEmbGl.Add(conf.fGet('SHERGL'));

    stlProEmbLa.Add(conf.fGet('BZCILA'));
    stlProEmbLa.Add(conf.fGet('BZCBZC'));
    stlProEmbLa.Add(conf.fGet('BZCLDU'));
    stlProEmbLa.Add(conf.fGet('BZCLAP'));
    stlProEmbLa.Add(conf.fGet('BZCLIL'));
    stlProEmbLa.Add(conf.fGet('BZCLCO'));
    stlProEmbLa.Add(conf.fGet('ULTRABASELA'));
    stlProEmbLa.Add(conf.fGet('PUMSLA'));
    stlProEmbLa.Add(conf.fGet('SHERLA'));

    strProEmbCo := conf.fGet('BZCCOP');
    strProEmbSp := conf.fGet('BZCSPR');

    frmDigTinta.stlDesEmb   := stlDesEmb;
    frmDigTinta.stlProEmbLt := stlProEmbLt;
    frmDigTinta.stlProEmbGl := stlProEmbGl;
    frmDigTinta.stlProEmbLa := stlProEmbLa;
    frmDigTinta.strProEmbCo := strProEmbCo;
    frmDigTinta.strProEmbSp := strProEmbSp;

    frmDigTinta.chkComCat.Visible := False;

    // Volume minímo permitido (C - Concentrado, D - Diluído).
    frmDigTinta.fltBZCVolMiC := dtsCadTin.FieldByName('BZC_VOLMIC').AsFloat;
    frmDigTinta.fltBZCVolMiD := dtsCadTin.FieldByName('BZC_VOLMID').AsFloat;

    frmDigTinta.fltVolumePadraoSpray := 0.100;

    frmDigTinta.intIndEmb            := intIndEmb;

    Result := (frmDigTinta.ShowModal = mrOk)
      And fValidaVolumeFormulucao(TAutcomTintaFactory.Get.IIF(frmDigTinta.rdgModoVenda.ItemIndex = 0, 'C', 'D'),
                                       dtsCadTin.FieldByName('BZC_VOLCON').AsFloat,
                                       dtsCadTin.FieldByName('BZC_VOLDIL').AsFloat);
  Finally
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlProEmbLa) then FreeAndNil(stlProEmbLa);
  End;
end;

end.
