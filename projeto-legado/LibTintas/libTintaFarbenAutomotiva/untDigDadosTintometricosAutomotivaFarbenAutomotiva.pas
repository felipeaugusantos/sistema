unit untDigDadosTintometricosAutomotivaFarbenAutomotiva;

interface

uses
  untDigDadosTintometricosAutomotiva, untIDataSet, untAbstractDigTintaAutomotiva,
  Classes, Controls, SysUtils;

type
  TDigDadosTintometricosAutomotivaFarbenAutomotiva = class(TDigDadosTintometricosAutomotiva)
  private

  public
    class function fPreencheProdutoEmbagemVendaFarbenAutomotiva(frmDigTinta: TfrmAbstractDigTintaAutomotiva; Const intIndEmb: integer; const dtsCadTin: IDataSet): Boolean;
  end;

implementation

uses untAutcomTintaFactory, untIConfTinta;

{ TDigDadosTintometricosAutomotivaFarbenAutomotiva }

class function TDigDadosTintometricosAutomotivaFarbenAutomotiva.fPreencheProdutoEmbagemVendaFarbenAutomotiva(
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
    conf := TAutcomTintaFactory.Get.fGetConfTinta('FAR');

    stlDesEmb   := TStringList.Create;
    stlProEmbLt := TStringList.Create;
    stlProEmbGl := TStringList.Create;
    stlProEmbLa := TStringList.Create;

    stlDesEmb.Add('FARZURIL');
    stlDesEmb.Add('FARZULAC');
    stlDesEmb.Add('FARZUDUR');
    stlDesEmb.Add('P. U.');
    stlDesEmb.Add('FARZUCRIL');
    stlDesEmb.Add('FLEET COLOR');
    stlDesEmb.Add('ULTRABASE');
    stlDesEmb.Add('FARZUDUR PU MS');
    stlDesEmb.Add('SHERTRUCKFAR');

    stlProEmbLt.Add(conf.fGet('FARIEM'));
    stlProEmbLt.Add(conf.fGet('FARLLA'));
    stlProEmbLt.Add(conf.fGet('FARLPO'));
    stlProEmbLt.Add(conf.fGet('FARLPU'));
    stlProEmbLt.Add(conf.fGet('FARLCR'));
    stlProEmbLt.Add(conf.fGet('FARLFL'));
    stlProEmbLt.Add(conf.fGet('ULTRABASELT'));
    stlProEmbLt.Add(conf.fGet('PUMSLT'));
    stlProEmbLt.Add(conf.fGet('SHERLT'));

    stlProEmbGl.Add(conf.fGet('FARIGL'));
    stlProEmbGl.Add(conf.fGet('FARGLA'));
    stlProEmbGl.Add(conf.fGet('FARGPO'));
    stlProEmbGl.Add(conf.fGet('FARGPU'));
    stlProEmbGl.Add(conf.fGet('FARGCR'));
    stlProEmbGl.Add(conf.fGet('FARGFL'));
    stlProEmbGl.Add(conf.fGet('ULTRABASEGL'));
    stlProEmbGl.Add(conf.fGet('PUMSGL'));
    stlProEmbGl.Add(conf.fGet('SHERGL'));

    stlProEmbLa.Add(conf.fGet('FARILA'));
    stlProEmbLa.Add(conf.fGet('FARFAR'));
    stlProEmbLa.Add(conf.fGet('FARLDU'));
    stlProEmbLa.Add(conf.fGet('FARLAP'));
    stlProEmbLa.Add(conf.fGet('FARLIL'));
    stlProEmbLa.Add(conf.fGet('FARLCO'));
    stlProEmbLa.Add(conf.fGet('ULTRABASELA'));
    stlProEmbLa.Add(conf.fGet('PUMSLA'));
    stlProEmbLa.Add(conf.fGet('SHERLA'));

    strProEmbCo := conf.fGet('FARCOP');
    strProEmbSp := conf.fGet('FARSPR');

    frmDigTinta.stlDesEmb   := stlDesEmb;
    frmDigTinta.stlProEmbLt := stlProEmbLt;
    frmDigTinta.stlProEmbGl := stlProEmbGl;
    frmDigTinta.stlProEmbLa := stlProEmbLa;
    frmDigTinta.strProEmbCo := strProEmbCo;
    frmDigTinta.strProEmbSp := strProEmbSp;

    frmDigTinta.chkComCat.Visible := False;

    // Volume minímo permitido (C - Concentrado, D - Diluído).
    frmDigTinta.fltFARVolMiC := dtsCadTin.FieldByName('FAR_VOLMIC').AsFloat;
    frmDigTinta.fltFARVolMiD := dtsCadTin.FieldByName('FAR_VOLMID').AsFloat;

    frmDigTinta.fltVolumePadraoSpray := 0.100;

    frmDigTinta.intIndEmb            := intIndEmb;

    Result := (frmDigTinta.ShowModal = mrOk)
      And fValidaVolumeFormulucao(TAutcomTintaFactory.Get.IIF(frmDigTinta.rdgModoVenda.ItemIndex = 0, 'C', 'D'),
                                       dtsCadTin.FieldByName('FAR_VOLCON').AsFloat,
                                       dtsCadTin.FieldByName('FAR_VOLDIL').AsFloat);
  Finally
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlProEmbLa) then FreeAndNil(stlProEmbLa);
  End;
end;

end.
