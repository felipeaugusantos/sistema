unit untDigDadosTintometricosAutomotivaMazaAutomotiva;

interface

uses
  untDigDadosTintometricosAutomotiva, untIDataSet, untAbstractDigTintaAutomotiva,
  Classes, Controls, SysUtils;

type
  TDigDadosTintometricosAutomotivaMazaAutomotiva = class(TDigDadosTintometricosAutomotiva)
  private

  public
    class function fPreencheProdutoEmbagemVendaMazaAutomotiva(frmDigTinta: TfrmAbstractDigTintaAutomotiva; Const intIndEmb: integer; const dtsCadTin: IDataSet): Boolean;
  end;

implementation

uses untAutcomTintaFactory, untIConfTinta;

{ TDigDadosTintometricosAutomotivaMazaAutomotiva }

class function TDigDadosTintometricosAutomotivaMazaAutomotiva.fPreencheProdutoEmbagemVendaMazaAutomotiva(
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
    conf := TAutcomTintaFactory.Get.fGetConfTinta('MZA');

    stlDesEmb   := TStringList.Create;
    stlProEmbLt := TStringList.Create;
    stlProEmbGl := TStringList.Create;
    stlProEmbLa := TStringList.Create;

    stlDesEmb.Add('MZAZURIL');
    stlDesEmb.Add('MZAZULAC');
    stlDesEmb.Add('MZAZUDUR');
    stlDesEmb.Add('P. U.');
    stlDesEmb.Add('MZAZUCRIL');
    stlDesEmb.Add('FLEET COLOR');
    stlDesEmb.Add('ULTRABASE');
    stlDesEmb.Add('MZAZUDUR PU MS');
    stlDesEmb.Add('SHERTRUCKMZA');

    stlProEmbLt.Add(conf.fGet('MZAIEM'));
    stlProEmbLt.Add(conf.fGet('MZALLA'));
    stlProEmbLt.Add(conf.fGet('MZALPO'));
    stlProEmbLt.Add(conf.fGet('MZALPU'));
    stlProEmbLt.Add(conf.fGet('MZALCR'));
    stlProEmbLt.Add(conf.fGet('MZALFL'));
    stlProEmbLt.Add(conf.fGet('ULTRABASELT'));
    stlProEmbLt.Add(conf.fGet('PUMSLT'));
    stlProEmbLt.Add(conf.fGet('SHERLT'));

    stlProEmbGl.Add(conf.fGet('MZAIGL'));
    stlProEmbGl.Add(conf.fGet('MZAGLA'));
    stlProEmbGl.Add(conf.fGet('MZAGPO'));
    stlProEmbGl.Add(conf.fGet('MZAGPU'));
    stlProEmbGl.Add(conf.fGet('MZAGCR'));
    stlProEmbGl.Add(conf.fGet('MZAGFL'));
    stlProEmbGl.Add(conf.fGet('ULTRABASEGL'));
    stlProEmbGl.Add(conf.fGet('PUMSGL'));
    stlProEmbGl.Add(conf.fGet('SHERGL'));

    stlProEmbLa.Add(conf.fGet('MZAILA'));
    stlProEmbLa.Add(conf.fGet('MZAMZA'));
    stlProEmbLa.Add(conf.fGet('MZALDU'));
    stlProEmbLa.Add(conf.fGet('MZALAP'));
    stlProEmbLa.Add(conf.fGet('MZALIL'));
    stlProEmbLa.Add(conf.fGet('MZALCO'));
    stlProEmbLa.Add(conf.fGet('ULTRABASELA'));
    stlProEmbLa.Add(conf.fGet('PUMSLA'));
    stlProEmbLa.Add(conf.fGet('SHERLA'));

    strProEmbCo := conf.fGet('MZACOP');
    strProEmbSp := conf.fGet('MZASPR');

    frmDigTinta.stlDesEmb   := stlDesEmb;
    frmDigTinta.stlProEmbLt := stlProEmbLt;
    frmDigTinta.stlProEmbGl := stlProEmbGl;
    frmDigTinta.stlProEmbLa := stlProEmbLa;
    frmDigTinta.strProEmbCo := strProEmbCo;
    frmDigTinta.strProEmbSp := strProEmbSp;

    frmDigTinta.chkComCat.Visible := False;

    // Volume minímo permitido (C - Concentrado, D - Diluído).
    frmDigTinta.fltMZAVolMiC := dtsCadTin.FieldByName('MZA_VOLMIC').AsFloat;
    frmDigTinta.fltMZAVolMiD := dtsCadTin.FieldByName('MZA_VOLMID').AsFloat;

    frmDigTinta.fltVolumePadraoSpray := 0.100;

    frmDigTinta.intIndEmb            := intIndEmb;

    Result := (frmDigTinta.ShowModal = mrOk)
      And fValidaVolumeFormulucao(TAutcomTintaFactory.Get.IIF(frmDigTinta.rdgModoVenda.ItemIndex = 0, 'C', 'D'),
                                       dtsCadTin.FieldByName('MZA_VOLCON').AsFloat,
                                       dtsCadTin.FieldByName('MZA_VOLDIL').AsFloat);
  Finally
    if Assigned(stlDesEmb) then FreeAndNil(stlDesEmb);
    if Assigned(stlProEmbLt) then FreeAndNil(stlProEmbLt);
    if Assigned(stlProEmbGl) then FreeAndNil(stlProEmbGl);
    if Assigned(stlProEmbLa) then FreeAndNil(stlProEmbLa);
  End;
end;

end.
