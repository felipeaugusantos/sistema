unit untDigDadosTintometricosAutomotivaNexa;

interface

uses
  untDigDadosTintometricosAutomotiva, untIDataSet, untAbstractDigTintaAutomotiva,
  Classes, Controls, SysUtils;

type
  TDigDadosTintometricosAutomotivaNexa = class(TDigDadosTintometricosAutomotiva)
  private

  public
    class function fPreencheProdutoEmbagemVendaNEX(frmDigTinta: TfrmAbstractDigTintaAutomotiva; Const intIndEmb: integer; const dtsCadTin: IDataSet): Boolean;
  end;

implementation

uses untAutcomTintaFactory, untIConfTinta;

{ TDigDadosTintometricosAutomotivaNexa }

class function TDigDadosTintometricosAutomotivaNexa.fPreencheProdutoEmbagemVendaNEX(
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
    conf := TAutcomTintaFactory.Get.fGetConfTinta('NEX');

    stlDesEmb   := TStringList.Create;
    stlProEmbLt := TStringList.Create;
    stlProEmbGl := TStringList.Create;
    stlProEmbLa := TStringList.Create;

    stlDesEmb.Add('NEXZURIL');
    stlDesEmb.Add('NEXZULAC');
    stlDesEmb.Add('NEXZUDUR');
    stlDesEmb.Add('P. U.');
    stlDesEmb.Add('NEXZUCRIL');
    stlDesEmb.Add('FLEET COLOR');
    stlDesEmb.Add('ULTRABASE');
    stlDesEmb.Add('NEXZUDUR PU MS');
    stlDesEmb.Add('SHERTRUCKNEX');

    stlProEmbLt.Add(conf.fGet('NEXIEM'));
    stlProEmbLt.Add(conf.fGet('NEXLLA'));
    stlProEmbLt.Add(conf.fGet('NEXLPO'));
    stlProEmbLt.Add(conf.fGet('NEXLPU'));
    stlProEmbLt.Add(conf.fGet('NEXLCR'));
    stlProEmbLt.Add(conf.fGet('NEXLFL'));
    stlProEmbLt.Add(conf.fGet('ULTRABASELT'));
    stlProEmbLt.Add(conf.fGet('PUMSLT'));
    stlProEmbLt.Add(conf.fGet('SHERLT'));

    stlProEmbGl.Add(conf.fGet('NEXIGL'));
    stlProEmbGl.Add(conf.fGet('NEXGLA'));
    stlProEmbGl.Add(conf.fGet('NEXGPO'));
    stlProEmbGl.Add(conf.fGet('NEXGPU'));
    stlProEmbGl.Add(conf.fGet('NEXGCR'));
    stlProEmbGl.Add(conf.fGet('NEXGFL'));
    stlProEmbGl.Add(conf.fGet('ULTRABASEGL'));
    stlProEmbGl.Add(conf.fGet('PUMSGL'));
    stlProEmbGl.Add(conf.fGet('SHERGL'));

    stlProEmbLa.Add(conf.fGet('NEXILA'));
    stlProEmbLa.Add(conf.fGet('NEXNEX'));
    stlProEmbLa.Add(conf.fGet('NEXLDU'));
    stlProEmbLa.Add(conf.fGet('NEXLAP'));
    stlProEmbLa.Add(conf.fGet('NEXLIL'));
    stlProEmbLa.Add(conf.fGet('NEXLCO'));
    stlProEmbLa.Add(conf.fGet('ULTRABASELA'));
    stlProEmbLa.Add(conf.fGet('PUMSLA'));
    stlProEmbLa.Add(conf.fGet('SHERLA'));

    strProEmbCo := conf.fGet('NEXCOP');
    strProEmbSp := conf.fGet('NEXSPR');

    frmDigTinta.stlDesEmb   := stlDesEmb;
    frmDigTinta.stlProEmbLt := stlProEmbLt;
    frmDigTinta.stlProEmbGl := stlProEmbGl;
    frmDigTinta.stlProEmbLa := stlProEmbLa;
    frmDigTinta.strProEmbCo := strProEmbCo;
    frmDigTinta.strProEmbSp := strProEmbSp;

    frmDigTinta.chkComCat.Visible := False;

    // Volume minímo permitido (C - Concentrado, D - Diluído).
    frmDigTinta.fltNEXVolMiC := dtsCadTin.FieldByName('NEX_VOLMIC').AsFloat;
    frmDigTinta.fltNEXVolMiD := dtsCadTin.FieldByName('NEX_VOLMID').AsFloat;

    frmDigTinta.fltVolumePadraoSpray := 0.100;

    frmDigTinta.intIndEmb            := intIndEmb;

    Result := (frmDigTinta.ShowModal = mrOk)
      And fValidaVolumeFormulucao(TAutcomTintaFactory.Get.IIF(frmDigTinta.rdgModoVenda.ItemIndex = 0, 'C', 'D'),
                                       dtsCadTin.FieldByName('NEX_VOLCON').AsFloat,
                                       dtsCadTin.FieldByName('NEX_VOLDIL').AsFloat);
  Finally
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlProEmbLa) then FreeAndNil(stlProEmbLa);
  End;
end;

end.
