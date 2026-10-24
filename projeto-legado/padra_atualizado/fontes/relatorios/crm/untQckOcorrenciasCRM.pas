unit untQckOcorrenciasCRM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frxClass, frxDBSet;

type
  TfrmQckOcorrenciasCRM = class(TForm)
    frxOcorrencias: TfrxReport;
    DBOcorrencias: TfrxDBDataset;
    DBProdutosDev: TfrxDBDataset;
    DBEnderecosDev: TfrxDBDataset;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

end.
