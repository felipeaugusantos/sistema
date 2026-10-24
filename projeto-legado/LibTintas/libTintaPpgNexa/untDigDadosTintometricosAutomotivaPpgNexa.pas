unit untDigDadosTintometricosAutomotivaPpgNexa;

interface

uses
  untDigDadosTintometricosAutomotiva, untIDataSet, untAbstractDigTintaAutomotiva,
  Classes, Controls, SysUtils;

type
  TDigDadosTintometricosAutomotivaPpgNexa = class(TDigDadosTintometricosAutomotiva)
  private

  public
    class function fPreencheProdutoEmbagemVendaPPX(frmDigTinta: TfrmAbstractDigTintaAutomotiva; Const intIndEmb: integer; const dtsCadTin: IDataSet): Boolean;
  end;

implementation

uses untAutcomTintaFactory, untIConfTinta;

{ TDigDadosTintometricosAutomotivaPpgNexa }

class function TDigDadosTintometricosAutomotivaPpgNexa.fPreencheProdutoEmbagemVendaPPX(
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
    conf := TAutcomTintaFactory.Get.fGetConfTinta('PPX');

    stlDesEmb   := TStringList.Create;
    stlProEmbLt := TStringList.Create;
    stlProEmbGl := TStringList.Create;
    stlProEmbLa := TStringList.Create;

    stlDesEmb.Add('PPXZURIL');
    stlDesEmb.Add('PPXZULAC');
    stlDesEmb.Add('PPXZUDUR');
    stlDesEmb.Add('P. U.');
    stlDesEmb.Add('PPXZUCRIL');
    stlDesEmb.Add('FLEET COLOR');
    stlDesEmb.Add('ULTRABASE');
    stlDesEmb.Add('PPXZUDUR PU MS');
    stlDesEmb.Add('SHERTRUCKPPX');

    stlProEmbLt.Add(conf.fGet('PPXIEM'));
    stlProEmbLt.Add(conf.fGet('PPXLLA'));
    stlProEmbLt.Add(conf.fGet('PPXLPO'));
    stlProEmbLt.Add(conf.fGet('PPXLPU'));
    stlProEmbLt.Add(conf.fGet('PPXLCR'));
    stlProEmbLt.Add(conf.fGet('PPXLFL'));
    stlProEmbLt.Add(conf.fGet('ULTRABASELT'));
    stlProEmbLt.Add(conf.fGet('PUMSLT'));
    stlProEmbLt.Add(conf.fGet('SHERLT'));

    stlProEmbGl.Add(conf.fGet('PPXIGL'));
    stlProEmbGl.Add(conf.fGet('PPXGLA'));
    stlProEmbGl.Add(conf.fGet('PPXGPO'));
    stlProEmbGl.Add(conf.fGet('PPXGPU'));
    stlProEmbGl.Add(conf.fGet('PPXGCR'));
    stlProEmbGl.Add(conf.fGet('PPXGFL'));
    stlProEmbGl.Add(conf.fGet('ULTRABASEGL'));
    stlProEmbGl.Add(conf.fGet('PUMSGL'));
    stlProEmbGl.Add(conf.fGet('SHERGL'));

    stlProEmbLa.Add(conf.fGet('PPXILA'));
    stlProEmbLa.Add(conf.fGet('PPXPPX'));
    stlProEmbLa.Add(conf.fGet('PPXLDU'));
    stlProEmbLa.Add(conf.fGet('PPXLAP'));
    stlProEmbLa.Add(conf.fGet('PPXLIL'));
    stlProEmbLa.Add(conf.fGet('PPXLCO'));
    stlProEmbLa.Add(conf.fGet('ULTRABASELA'));
    stlProEmbLa.Add(conf.fGet('PUMSLA'));
    stlProEmbLa.Add(conf.fGet('SHERLA'));

    strProEmbCo := conf.fGet('PPXCOP');
    strProEmbSp := conf.fGet('PPXSPR');

    frmDigTinta.stlDesEmb   := stlDesEmb;
    frmDigTinta.stlProEmbLt := stlProEmbLt;
    frmDigTinta.stlProEmbGl := stlProEmbGl;
    frmDigTinta.stlProEmbLa := stlProEmbLa;
    frmDigTinta.strProEmbCo := strProEmbCo;
    frmDigTinta.strProEmbSp := strProEmbSp;

    frmDigTinta.chkComCat.Visible := False;

    // Volume minímo permitido (C - Concentrado, D - Diluído).
    frmDigTinta.fltPPXVolMiC := dtsCadTin.FieldByName('PPX_VOLMIC').AsFloat;
    frmDigTinta.fltPPXVolMiD := dtsCadTin.FieldByName('PPX_VOLMID').AsFloat;

    frmDigTinta.fltVolumePadraoSpray := 0.100;

    frmDigTinta.intIndEmb            := intIndEmb;

    Result := (frmDigTinta.ShowModal = mrOk)
      And fValidaVolumeFormulucao(TAutcomTintaFactory.Get.IIF(frmDigTinta.rdgModoVenda.ItemIndex = 0, 'C', 'D'),
                                       dtsCadTin.FieldByName('PPX_VOLCON').AsFloat,
                                       dtsCadTin.FieldByName('PPX_VOLDIL').AsFloat);
  Finally
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlProEmbLa) then FreeAndNil(stlProEmbLa);
  End;
end;

end.
