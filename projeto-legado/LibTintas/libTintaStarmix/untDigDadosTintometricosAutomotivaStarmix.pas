unit untDigDadosTintometricosAutomotivaStarmix;

interface

uses
  untDigDadosTintometricosAutomotiva, untIDataSet, untAbstractDigTintaAutomotiva,
  Classes, Controls, SysUtils;

type
  TDigDadosTintometricosAutomotivaStarmix = class(TDigDadosTintometricosAutomotiva)
  private

  public
    class function fPreencheProdutoEmbagemVendaStarmix(frmDigTinta: TfrmAbstractDigTintaAutomotiva; Const intIndEmb: integer; const dtsCadTin: IDataSet): Boolean;
  end;

implementation

uses untAutcomTintaFactory, untIConfTinta;

{ TDigDadosTintometricosAutomotivaStarmix }

class function TDigDadosTintometricosAutomotivaStarmix.fPreencheProdutoEmbagemVendaStarmix(
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
    conf := TAutcomTintaFactory.Get.fGetConfTinta('LAZ');

    stlDesEmb   := TStringList.Create;
    stlProEmbLt := TStringList.Create;
    stlProEmbGl := TStringList.Create;
    stlProEmbLa := TStringList.Create;

    stlDesEmb.Add('LAZZURIL');
    stlDesEmb.Add('LAZZULAC');
    stlDesEmb.Add('LAZZUDUR');
    stlDesEmb.Add('P. U.');
    stlDesEmb.Add('LAZZUCRIL');
    stlDesEmb.Add('FLEET COLOR');
    stlDesEmb.Add('ULTRABASE');
    stlDesEmb.Add('LAZZUDUR PU MS');
    stlDesEmb.Add('SHERTRUCKMIX');

    stlProEmbLt.Add(conf.fGet('LAZIEM'));
    stlProEmbLt.Add(conf.fGet('LAZLLA'));
    stlProEmbLt.Add(conf.fGet('LAZLPO'));
    stlProEmbLt.Add(conf.fGet('LAZLPU'));
    stlProEmbLt.Add(conf.fGet('LAZLCR'));
    stlProEmbLt.Add(conf.fGet('LAZLFL'));
    stlProEmbLt.Add(conf.fGet('ULTRABASELT'));
    stlProEmbLt.Add(conf.fGet('PUMSLT'));
    stlProEmbLt.Add(conf.fGet('SHERLT'));

    stlProEmbGl.Add(conf.fGet('LAZIGL'));
    stlProEmbGl.Add(conf.fGet('LAZGLA'));
    stlProEmbGl.Add(conf.fGet('LAZGPO'));
    stlProEmbGl.Add(conf.fGet('LAZGPU'));
    stlProEmbGl.Add(conf.fGet('LAZGCR'));
    stlProEmbGl.Add(conf.fGet('LAZGFL'));
    stlProEmbGl.Add(conf.fGet('ULTRABASEGL'));
    stlProEmbGl.Add(conf.fGet('PUMSGL'));
    stlProEmbGl.Add(conf.fGet('SHERGL'));

    stlProEmbLa.Add(conf.fGet('LAZILA'));
    stlProEmbLa.Add(conf.fGet('LAZLAZ'));
    stlProEmbLa.Add(conf.fGet('LAZLDU'));
    stlProEmbLa.Add(conf.fGet('LAZLAP'));
    stlProEmbLa.Add(conf.fGet('LAZLIL'));
    stlProEmbLa.Add(conf.fGet('LAZLCO'));
    stlProEmbLa.Add(conf.fGet('ULTRABASELA'));
    stlProEmbLa.Add(conf.fGet('PUMSLA'));
    stlProEmbLa.Add(conf.fGet('SHERLA'));

    strProEmbCo := conf.fGet('LAZCOP');
    strProEmbSp := conf.fGet('LAZSPR');

    frmDigTinta.stlDesEmb   := stlDesEmb;
    frmDigTinta.stlProEmbLt := stlProEmbLt;
    frmDigTinta.stlProEmbGl := stlProEmbGl;
    frmDigTinta.stlProEmbLa := stlProEmbLa;
    frmDigTinta.strProEmbCo := strProEmbCo;
    frmDigTinta.strProEmbSp := strProEmbSp;

    frmDigTinta.chkComCat.Visible := False;

    // Volume minímo permitido (C - Concentrado, D - Diluído).
    frmDigTinta.fltMixVolMiC := dtsCadTin.FieldByName('MIX_VOLMIC').AsFloat;
    frmDigTinta.fltMixVolMiD := dtsCadTin.FieldByName('MIX_VOLMID').AsFloat;

    frmDigTinta.fltVolumePadraoSpray := 0.100;

    frmDigTinta.intIndEmb            := intIndEmb;

    Result := (frmDigTinta.ShowModal = mrOk)
      And fValidaVolumeFormulucao(TAutcomTintaFactory.Get.IIF(frmDigTinta.rdgModoVenda.ItemIndex = 0, 'C', 'D'),
                                       dtsCadTin.FieldByName('MIX_VOLCON').AsFloat,
                                       dtsCadTin.FieldByName('MIX_VOLDIL').AsFloat);
  Finally
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlProEmbLa) then FreeAndNil(stlProEmbLa);
  End;
end;

end.
