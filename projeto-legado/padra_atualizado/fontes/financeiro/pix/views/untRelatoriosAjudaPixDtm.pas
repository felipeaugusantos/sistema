unit untRelatoriosAjudaPixDtm;

interface

uses
  System.SysUtils, System.Classes, frxClass, Forms, frxDBSet;

type
  TdtmRelatoriosAjudaPixDtm = class(TForm)
    frxChavesAutorizacao: TfrxReport;
    frxData: TfrxDBDataset;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmRelatoriosAjudaPixDtm: TdtmRelatoriosAjudaPixDtm;

implementation
Uses untFuncoesSimples;
{$R *.dfm}

procedure TdtmRelatoriosAjudaPixDtm.FormCreate(Sender: TObject);
begin
 TfrxPage(frxChavesAutorizacao.Pages[0]).Height := 29.70;
 frxData.DataSet := fCriarQuery('SELECT EMP_CODEMP FROM CADEMP WHERE EMP_CODEMP="' + VS_strCodEmp + '"');
 frxData.DataSet.Open;
end;

end.
