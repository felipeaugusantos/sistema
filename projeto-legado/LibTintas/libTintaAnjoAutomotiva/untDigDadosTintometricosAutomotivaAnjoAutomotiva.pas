unit untDigDadosTintometricosAutomotivaAnjoAutomotiva;

interface

uses
  untDigDadosTintometricosAutomotiva, untIDataSet, untAbstractDigTintaAutomotiva,
  Classes, Controls, SysUtils;

type
  TDigDadosTintometricosAutomotivaAnjoAutomotiva = class(TDigDadosTintometricosAutomotiva)
  private

  public
    class function fPreencheProdutoEmbagemVendaAnjoAutomotiva(frmDigTinta: TfrmAbstractDigTintaAutomotiva; Const intIndEmb: integer; const dtsCadTin: IDataSet): Boolean;
  end;

implementation

uses untAutcomTintaFactory, untIConfTinta;

{ TDigDadosTintometricosAutomotivaAnjoAutomotiva }

class function TDigDadosTintometricosAutomotivaAnjoAutomotiva.fPreencheProdutoEmbagemVendaAnjoAutomotiva(
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
    conf := TAutcomTintaFactory.Get.fGetConfTinta('AJT');

    stlDesEmb   := TStringList.Create;
    stlProEmbLt := TStringList.Create;
    stlProEmbGl := TStringList.Create;
    stlProEmbLa := TStringList.Create;

    stlDesEmb.Add('AJTZURIL');
    stlDesEmb.Add('AJTZULAC');
    stlDesEmb.Add('AJTZUDUR');
    stlDesEmb.Add('P. U.');
    stlDesEmb.Add('AJTZUCRIL');
    stlDesEmb.Add('FLEET COLOR');
    stlDesEmb.Add('ULTRABASE');
    stlDesEmb.Add('AJTZUDUR PU MS');
    stlDesEmb.Add('SHERTRUCKAJT');

    stlProEmbLt.Add(conf.fGet('AJTIEM'));
    stlProEmbLt.Add(conf.fGet('AJTLLA'));
    stlProEmbLt.Add(conf.fGet('AJTLPO'));
    stlProEmbLt.Add(conf.fGet('AJTLPU'));
    stlProEmbLt.Add(conf.fGet('AJTLCR'));
    stlProEmbLt.Add(conf.fGet('AJTLFL'));
    stlProEmbLt.Add(conf.fGet('ULTRABASELT'));
    stlProEmbLt.Add(conf.fGet('PUMSLT'));
    stlProEmbLt.Add(conf.fGet('SHERLT'));

    stlProEmbGl.Add(conf.fGet('AJTIGL'));
    stlProEmbGl.Add(conf.fGet('AJTGLA'));
    stlProEmbGl.Add(conf.fGet('AJTGPO'));
    stlProEmbGl.Add(conf.fGet('AJTGPU'));
    stlProEmbGl.Add(conf.fGet('AJTGCR'));
    stlProEmbGl.Add(conf.fGet('AJTGFL'));
    stlProEmbGl.Add(conf.fGet('ULTRABASEGL'));
    stlProEmbGl.Add(conf.fGet('PUMSGL'));
    stlProEmbGl.Add(conf.fGet('SHERGL'));

    stlProEmbLa.Add(conf.fGet('AJTILA'));
    stlProEmbLa.Add(conf.fGet('AJTAJT'));
    stlProEmbLa.Add(conf.fGet('AJTLDU'));
    stlProEmbLa.Add(conf.fGet('AJTLAP'));
    stlProEmbLa.Add(conf.fGet('AJTLIL'));
    stlProEmbLa.Add(conf.fGet('AJTLCO'));
    stlProEmbLa.Add(conf.fGet('ULTRABASELA'));
    stlProEmbLa.Add(conf.fGet('PUMSLA'));
    stlProEmbLa.Add(conf.fGet('SHERLA'));

    strProEmbCo := conf.fGet('AJTCOP');
    strProEmbSp := conf.fGet('AJTSPR');

    frmDigTinta.stlDesEmb   := stlDesEmb;
    frmDigTinta.stlProEmbLt := stlProEmbLt;
    frmDigTinta.stlProEmbGl := stlProEmbGl;
    frmDigTinta.stlProEmbLa := stlProEmbLa;
    frmDigTinta.strProEmbCo := strProEmbCo;
    frmDigTinta.strProEmbSp := strProEmbSp;

    frmDigTinta.chkComCat.Visible := False;

    // Volume minímo permitido (C - Concentrado, D - Diluído).
    frmDigTinta.fltAJTVolMiC := dtsCadTin.FieldByName('AJT_VOLMIC').AsFloat;
    frmDigTinta.fltAJTVolMiD := dtsCadTin.FieldByName('AJT_VOLMID').AsFloat;

    frmDigTinta.fltVolumePadraoSpray := 0.100;

    frmDigTinta.intIndEmb            := intIndEmb;

    Result := (frmDigTinta.ShowModal = mrOk)
      And fValidaVolumeFormulucao(TAutcomTintaFactory.Get.IIF(frmDigTinta.rdgModoVenda.ItemIndex = 0, 'C', 'D'),
                                       dtsCadTin.FieldByName('AJT_VOLCON').AsFloat,
                                       dtsCadTin.FieldByName('AJT_VOLDIL').AsFloat);
  Finally
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlProEmbLa) then FreeAndNil(stlProEmbLa);
  End;
end;

end.
