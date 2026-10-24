unit untFatFormulacaoEtiqueta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, frxDBSet, DB,  frxBarcode, Uni, untTypesSistema,
  untFuncoesSimples, untFuncoesEtiquetas;

type
  TfrmFatFormulacaoEtiqueta = class(TForm)
    frxBarCodeObject1: TfrxBarCodeObject;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure pImprimeEtiqueta(qryImpressao: TDataSet; ftiDadosEtiq: TFormulEtiq; Operador: String = '');
  end;

var
  frmFatFormulacaoEtiqueta: TfrmFatFormulacaoEtiqueta;

implementation

uses  untFuncoesRel,untFuncEspecificas, TypesRel;

{$R *.dfm}

{ TForm1 }


procedure TfrmFatFormulacaoEtiqueta.pImprimeEtiqueta(qryImpressao: TDataSet;
  ftiDadosEtiq: TFormulEtiq; Operador: String = '');
  Var
    prmDllEtq: TParamDllEtiquetas;
begin
  Try
    prmDllEtq := TParamDllEtiquetas.Create;
    prmDllEtq.tpeTipEtq := tpeFomulacaoTinta;
    prmDllEtq.dtsImpres := qryImpressao;
    prmDllEtq.ftiDadEti := ftiDadosEtiq;
    prmDllEtq.strOperador := Operador;

    fImprimeEtiqueta(prmDllEtq);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaEntregaTinta]');
  End;
end;

end.
