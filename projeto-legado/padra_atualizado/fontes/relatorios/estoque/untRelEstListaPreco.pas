{*********************************************************}
{* RELATÓRIO DE LISTA DE PRECOS "PRIMEIRO NO FAST"       *}
{*                                                       *}
{* DATA......: 18/09/2007                                *}
{* AUTOR.....: ALEXANDRE OLIVEIRA FERRI "FALTA MUITO???" *}
{*                                                       *}
{******************************************************AF*}
unit untRelEstListaPreco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorioFast, frxExportTXT, frxExportRTF, frxExportXLS,
  frxExportHTML, frxExportPDF, frxClass, frxDMPExport, frxDBSet, Menus,
  StdCtrls, EditFocus, QColorLabel, Buttons, ExtCtrls;

type
  TfrmRelEstListaPreco = class(TfrmPaiRelatorioFast)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelEstListaPreco: TfrmRelEstListaPreco;

implementation

{$R *.dfm}

end.
