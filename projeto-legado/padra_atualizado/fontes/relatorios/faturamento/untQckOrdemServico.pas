{*********************************************************}
{* QCK DA IMPRESSAO DA ORDEM DE SERVICO                  *}
{*                                                       *}
{* DATA......: 03/10/2007                                *}
{* AUTOR.....: ALEXANDRE OLIVEIRA FERRI "FALTA MUITO???" *}
{*                                                       *}
{******************************************************AF*}
unit untQckOrdemServico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, frxDBSet, frxExportXLS, frxExportRTF, frxExportPDF, frxDMPExport,
  frxExportHTML, frxDesgn;

type
  TfrmQckOrdemServico = class(TForm)
    frxDesigner: TfrxDesigner;
    frxExpHtml: TfrxHTMLExport;
    frxMatricial: TfrxDotMatrixExport;
    frxExpPDF: TfrxPDFExport;
    frxExpRTF: TfrxRTFExport;
    frxExpXLS: TfrxXLSExport;
    frxRelatorio: TfrxDBDataset;
    frxComandos: TfrxUserDataSet;
    frxGen: TfrxUserDataSet;
    frxRelatorioJ: TfrxReport;
    frxRelatorioM: TfrxReport;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses untFuncoes, untfuncoesSimples;

{$R *.dfm}

end.

